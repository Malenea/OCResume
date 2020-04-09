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
class SettingsViewController: PresentedBaseViewController {

    // Coordinator and view model
    weak var coordinator: SettingsCoordinator?
    private var settingsViewModel: SettingsViewModel? {
        return viewModel as? SettingsViewModel
    }

    // Views and components
    private var titleLabel: UILabel!

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
    }

    // Setup views' layouts
    func setupLayout() {
        setupTitleLabelLayout()
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

    // Setting layout
    func setupTitleLabelLayout() {
        titleLabel.topAnchor.constraint(equalTo: topHeader.bottomAnchor, constant: 16.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
    }

    // setting gestures and buttons methods
    func addCloseButtonTarget() {
        closeButton.addTarget(self, action: #selector(tappedOnCloseButton), for: .touchUpInside)
    }
    
    @objc func tappedOnCloseButton(_ sender: UIButton) {
        coordinator?.dismiss()
    }

}
