//
//  LanguageViewController.swift
//  OCResume
//
//  Created by Olivier Conan on 28/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

class LanguageViewController: BackBaseViewController {

    // Coordinator and view model
    weak var coordinator: SettingsCoordinator?
    private var languageViewModel: LanguageViewModel? {
        return viewModel as? LanguageViewModel
    }

    // Views and components

    // MARK: Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        setupLayout()
    }

    override func tappedOnBackButton(_ sender: UIButton) {
        super.tappedOnBackButton(sender)

        coordinator?.moveBackToSettings()
    }

}

// MARK: Views creations and setups
extension LanguageViewController {

    // Generic setup
    func setup() {
        addBackButtonTarget()
        addTitleAndBorders()

        setupViews()
    }

    // Setup of additional views
    func setupViews() {
        setupLanguageButtons()
    }

    // Setup views' layouts
    func setupLayout() {
        setupSwitchButtonLayout()
    }

    // MARK: Setting views
    func setupLanguageButtons() {
        guard let viewModel = languageViewModel else { return }

        // Creating view

        // Setting view properties
    }

    // Setting layout
    func setupSwitchButtonLayout() {
    }

    // MARK: Setting titles
    func addTitleAndBorders() {
        guard let viewModel = languageViewModel else { return }

        borderView.layer.borderColor = viewModel.color.cgColor

        titleLabel.textColor = viewModel.color
        titleLabel.text = viewModel.title
    }

    // MARK: Setting gestures and buttons methods
    func addBackButtonTarget() {
        if let viewModel = languageViewModel {
            backButton.setImage(UIImage(named: "ic_back")?.maskWithColor(color: viewModel.color), for: .normal)
        }
        backButton.addTarget(self, action: #selector(tappedOnBackButton), for: .touchUpInside)
    }

}
