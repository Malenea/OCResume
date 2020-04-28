//
//  SettingsViewController.swift
//  OCResume
//
//  Created by Olivier Conan on 09/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// MARK: Overrides and inits
class SettingsViewController: PresentedBaseViewController, DarkProtocol {

    // Dark protocol
    func reloadView() {
        backgroundView.backgroundColor = .getBackgroundColor()
        titleLabel.textColor = .getComponentColor()
        for case let cell as SettingsTableViewCell in menuView.visibleCells {
            cell.reloadView()
        }
    }

    // Coordinator and view model
    weak var coordinator: SettingsCoordinator?
    private var settingsViewModel: SettingsViewModel? {
        return viewModel as? SettingsViewModel
    }

    // Views and components
    private var titleLabel: UILabel!
    private var menuView: UITableView!

    // Inits
    override init(nibName: String? = nil, bundle: Bundle? = nil, baseViewModel: BaseViewModel) {
        super.init(baseViewModel: baseViewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        setupLayout()
    }

}

// MARK: Views creations and setups
extension SettingsViewController {

    // Generic setup
    func setup() {
        // Set the close button if not iOS13+
        if !isIOS13 {
            addCloseButtonTarget()
        }

        setupViews()
    }

    // Setup of additional views
    func setupViews() {
        setupTitleLabel()
        setupMenuView()
    }

    // Setup views' layouts
    func setupLayout() {
        setupTitleLabelLayout()
        setupMenuViewLayout()
    }

    // Setting views
    func setupTitleLabel() {
        guard let viewModel = settingsViewModel else { return }

        // Creating view
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        // Setting view properties
        titleLabel.text = viewModel.title
        titleLabel.font = .title
        titleLabel.textColor = .getComponentColor()
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
    }

    func setupMenuView() {
        guard let viewModel = settingsViewModel else { return }

        // Creating view
        menuView = UITableView()
        menuView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuView)

        // Setting view properties
        menuView.backgroundColor = .clear
        menuView.separatorStyle = .none
        menuView.isScrollEnabled = false
        menuView.delegate = self
        menuView.dataSource = self

        let identifiers = viewModel.settingsButtons.map { $0.id }
        for identifier in identifiers {
            menuView.register(SettingsTableViewCell.self, forCellReuseIdentifier: identifier)
        }
    }

    // Setting layout
    func setupTitleLabelLayout() {
        let topPadding = isIOS13 ? 0.0 : UIApplication.shared.statusBarFrame.height
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding + PPaddings.interPadding).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PPaddings.interPadding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PPaddings.interPadding).isActive = true
    }

    func setupMenuViewLayout() {
        let bottomPadding = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0) + PPaddings.interPadding
        menuView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: (PPaddings.interPadding) * 3.0).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomPadding).isActive = true
        menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PPaddings.interPadding).isActive = true
        menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: PPaddings.interPadding).isActive = true
    }

    // setting gestures and buttons methods
    func addCloseButtonTarget() {
        closeButton.addTarget(self, action: #selector(tappedOnCloseButton), for: .touchUpInside)
    }
    
    @objc func tappedOnCloseButton(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5, animations: {
            sender.transform = CGAffineTransform(rotationAngle: .pi)
        }) { [weak self] _ in
            self?.coordinator?.dismiss()
        }
    }

}

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? SingleTableViewCell else { return }

        let animation = SingleCellAnimationFactory.makePulseAnimation(duration: 0.5, delayFactor: 0.5, color: cell.color.cgColor)
        let animator = SingleCellAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }

}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let settingsViewModel = settingsViewModel else { return 0 }
        return settingsViewModel.settingsButtons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let settingsViewModel = settingsViewModel else { return UITableViewCell() }
        let cellItem = settingsViewModel.settingsButtons[indexPath.row]
        let identifier = cellItem.id
        if let cell = menuView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SettingsTableViewCell {
            cell.bind(viewModel: SettingsTableViewCellViewModel(button: cellItem))
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Height of cell should be 48.0 + padding 8.0
        return 56.0
    }

}

// MARK: Delegate for cell
extension SettingsViewController: SingleTableViewCellDelegate {

    func didTapOnSingleTableViewCell(_ singleTableViewCell: SingleTableViewCell) {
        guard let settingsTableViewCell = singleTableViewCell as? SettingsTableViewCell, let button = settingsTableViewCell.settingsTableViewCellViewModel?.button else { return }
        let cellFrame = singleTableViewCell.convert(singleTableViewCell.bounds, to: view)
        coordinator?.moveToTest(button: button, color: singleTableViewCell.color, rect: cellFrame)
    }

}
