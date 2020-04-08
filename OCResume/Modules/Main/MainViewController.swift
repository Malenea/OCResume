//
//  MainViewController.swift
//  Playground
//
//  Created by Olivier Conan on 11/03/2020.
//  Copyright © 2020 Medopad. All rights reserved.
//

import Foundation
import UIKit

// MARK: Overrides and inits
class MainViewController: BaseViewController {

    // Coordinator and view model
    weak var coordinator: RootCoordinator?
    private var mainViewModel: MainViewModel? {
        return viewModel as? MainViewModel
    }

    // Views and components
    private var settingsButton: UIButton!
    private var bottomMenuView: UIStackView!

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
    }

    // Setup of additional views
    func setupViews() {
        setupBottomMenuView()
    }

    // Setup views' layouts
    func setupLayout() {
        setupBottomMenuViewLayout()
    }

    // Setting views
    func setupBottomMenuView() {
        guard let viewModel = mainViewModel else { return }

        // Creating view
        bottomMenuView = UIStackView()
        bottomMenuView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomMenuView)

        // Setting view properties
        bottomMenuView.axis = .horizontal
        bottomMenuView.alignment = .fill
        bottomMenuView.distribution = .equalSpacing
        bottomMenuView.spacing = 8.0

        let mainMenuButtons = viewModel.mainMenuButtons
        for mainMenuButton in mainMenuButtons {
            let actionButton = ActionButton()
            actionButton.changeTitleLabel(to: mainMenuButton.title)
            bottomMenuView.addArrangedSubview(actionButton)
        }
    }

    // Setting each view's layout
    func setupBottomMenuViewLayout() {
        // Creating view's constraints
        let bottomPadding = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0) + 8.0
        bottomMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomPadding).isActive = true
        bottomMenuView.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        bottomMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        bottomMenuView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
    }

}
