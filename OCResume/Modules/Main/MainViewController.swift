//
//  MainViewController.swift
//  Playground
//
//  Created by Olivier Conan on 11/03/2020.
//  Copyright © 2020 Medopad. All rights reserved.
//

import Foundation
import UIKit

// MARK: State enum
enum MainState: String {

    case home
    case profile
    case stats
    
}

// MARK: Overrides and inits
class MainViewController: BaseViewController {

    // View model
    private var mainViewModel: MainViewModel? {
        return viewModel as? MainViewModel
    }

    // Control variables
    private var currentState: MainState!

    // Views and components
    private var settingsButton: UIButton!
    private var bottomMenuViewContainerView: UIView!
    private var bottomMenuView: UIStackView!
    private var containerView: UIView!

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
extension MainViewController {

    // Generic setup
    func setup() {
        setupViews()
        setupState()
    }

    // Setup and default the current state to index 0
    func setupState() {
        // Setting view properties
        if let viewModel = mainViewModel,
            let firstMainMenuItem = viewModel.mainMenuButtons.first {
            if let firstButton = bottomMenuView.arrangedSubviews.first as? ActionButton {
                firstButton.actionButtonBorderColor = firstMainMenuItem.color
            }
            currentState = firstMainMenuItem.type
            containerView.backgroundColor = firstMainMenuItem.color
        }
    }

    // Setup of additional views
    func setupViews() {
        setupContainerView()
        setupBottomMenuViewContainerView()
        setupBottomMenuView()
        setupSettingsButton()
    }

    // Setup views' layouts
    func setupLayout() {
        setupContainerViewLayout()
        setupBottomMenuViewContainerViewLayout()
        setupBottomMenuViewLayout()
        setupSettingsButtonLayout()
    }

    // Setting views
    func setupContainerView() {
        // Creating view
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
    }

    func setupBottomMenuViewContainerView() {
        bottomMenuViewContainerView = UIView()
        bottomMenuViewContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomMenuViewContainerView)

        // Setting view properties
        bottomMenuViewContainerView.backgroundColor = .getBackgroundColor()
    }

    func setupBottomMenuView() {
        guard let viewModel = mainViewModel else { return }

        // Creating view
        bottomMenuView = UIStackView()
        bottomMenuView.translatesAutoresizingMaskIntoConstraints = false
        bottomMenuViewContainerView.addSubview(bottomMenuView)

        // Setting view properties
        bottomMenuView.axis = .horizontal
        bottomMenuView.alignment = .fill
        bottomMenuView.distribution = .fillEqually
        bottomMenuView.spacing = 8.0
        bottomMenuView.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)

        let mainMenuButtons = viewModel.mainMenuButtons
        for (index, mainMenuButton) in mainMenuButtons.enumerated() {
            let actionButton = ActionButton()
            actionButton.actionButtonDelegate = self
            actionButton.tag = index
            actionButton.actionButtonIdentifier = mainMenuButton.id
            actionButton.pulsatorColor = mainMenuButton.color
            actionButton.changeTitleLabel(to: mainMenuButton.title)
            bottomMenuView.addArrangedSubview(actionButton)
        }
    }

    func setupSettingsButton() {
        // Creating view
        settingsButton = UIButton()
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsButton)

        // Setting view properties
        settingsButton.layer.cornerRadius = 24.0
        settingsButton.backgroundColor = .getComponentColor()
        settingsButton.addTarget(self, action: #selector(tappedOnButton), for: .touchUpInside)
    }

    // Setting each view's layout
    func setupContainerViewLayout() {
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    func setupBottomMenuViewContainerViewLayout() {
        let bottomPadding = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0) + 8.0
        bottomMenuViewContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomMenuViewContainerView.heightAnchor.constraint(equalToConstant: 64.0 + bottomPadding).isActive = true
        bottomMenuViewContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomMenuViewContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    func setupBottomMenuViewLayout() {
        let bottomPadding = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0) + 8.0
        bottomMenuView.topAnchor.constraint(equalTo: bottomMenuViewContainerView.topAnchor, constant: 16.0).isActive = true
        bottomMenuView.bottomAnchor.constraint(equalTo: bottomMenuViewContainerView.bottomAnchor, constant: -bottomPadding).isActive = true
        bottomMenuView.leadingAnchor.constraint(equalTo: bottomMenuViewContainerView.leadingAnchor, constant: 16.0).isActive = true
        bottomMenuView.trailingAnchor.constraint(equalTo: bottomMenuViewContainerView.trailingAnchor, constant: -16.0).isActive = true
    }

    func setupSettingsButtonLayout() {
        let topPadding = UIApplication.shared.statusBarFrame.height + 16.0
        settingsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding).isActive = true
        settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 48.0).isActive = true
    }

    // setting gestures and buttons methods
    @objc func tappedOnButton(_ sender: UIButton) {
        coordinator?.moveToSettings()
    }

}

extension MainViewController: ActionButtonDelegate {

    func resetButtons() {
        for case let button as ActionButton in bottomMenuView.arrangedSubviews {
            button.actionButtonBorderColor = .clear
        }
    }

    func didPress(_ actionButton: ActionButton) {
        guard let viewModel = mainViewModel else { return }
        let item = viewModel.mainMenuButtons[actionButton.tag]

        // If the type isn't set, it's an error, do nothing
        guard let type = item.type else { return }

        // Reset the buttons borders before assigning the new one
        resetButtons()

        let buttonY = containerView.frame.height - bottomMenuViewContainerView.frame.height + actionButton.center.y
        let point = CGPoint(x: actionButton.center.x, y: buttonY)
        containerView.createPulsator(point: point, width: view.frame.height, color: item.color.cgColor, isSolid: true) { [weak self] in
            self?.currentState = type
            self?.containerView.backgroundColor = item.color
            actionButton.actionButtonBorderColor = item.color
        }
    }

}
