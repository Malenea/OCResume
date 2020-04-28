//
//  ModeViewController.swift
//  OCResume
//
//  Created by Olivier Conan on 27/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

class ModeViewController: BackBaseViewController {

    // Coordinator and view model
    weak var coordinator: SettingsCoordinator?
    private var modeViewModel: ModeViewModel? {
        return viewModel as? ModeViewModel
    }

    // Views and components
    private var switchButton: ActionButton!

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
extension ModeViewController {

    // Generic setup
    func setup() {
        addBackButtonTarget()
        addTitleAndBorders()

        setupViews()
    }

    // Setup of additional views
    func setupViews() {
        setupSwitchButton()
    }

    // Setup views' layouts
    func setupLayout() {
        setupSwitchButtonLayout()
    }

    // MARK: Setting views
    func setupSwitchButton() {
        guard let viewModel = modeViewModel else { return }

        // Creating view
        switchButton = ActionButton()
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(switchButton)

        // Setting view properties
        switchButton.actionButtonDelegate = self
        switchButton.isPulsatorSolid = true
        switchButton.actionButtonBackgroundColor = darkMode ? .white : .charcoalGray
        switchButton.pulsatorColor = darkMode ? .charcoalGray : .white
        switchButton.changeTitleLabel(to: darkMode ? viewModel.offTitle : viewModel.onTitle)
    }

    // Setting layout
    func setupSwitchButtonLayout() {
        switchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: topHeader.frame.height).isActive = true
        switchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        switchButton.heightAnchor.constraint(equalToConstant: PPaddings.fullScreenComponentPadding).isActive = true
        switchButton.widthAnchor.constraint(equalToConstant: PPaddings.fullScreenComponentPadding).isActive = true
    }

    // MARK: Setting titles and borders
    func addTitleAndBorders() {
        guard let viewModel = modeViewModel else { return }

        borderView.layer.borderColor = viewModel.color.cgColor

        titleLabel.textColor = viewModel.color
        titleLabel.text = viewModel.title
    }

    // MARK: Setting gestures and buttons methods
    func addBackButtonTarget() {
        if let viewModel = modeViewModel {
            backButton.setImage(UIImage(named: "ic_back")?.maskWithColor(color: viewModel.color), for: .normal)
        }
        backButton.addTarget(self, action: #selector(tappedOnBackButton), for: .touchUpInside)
    }

}

extension ModeViewController: ActionButtonDelegate {

    func didPress(_ actionButton: ActionButton) {
        guard let viewModel = modeViewModel else { return }

        actionButton.isUserInteractionEnabled = false

        darkMode.toggle()
        coordinator?.updateSettings()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.cacheView.backgroundColor = .getBackgroundColor()
        }
        backgroundView.createPulsator(point: view.center, width: view.frame.height, color: .getBackgroundColor(), isSolid: true, duration: 2.0) { [weak self] in
            self?.backgroundView.backgroundColor = .getBackgroundColor()
            actionButton.isUserInteractionEnabled = true
        }
        actionButton.animateButton() {
            actionButton.actionButtonBackgroundColor = .getComponentColor()
            actionButton.pulsatorColor = .getBackgroundColor()
            actionButton.changeTitleLabel(to: darkMode ? viewModel.offTitle : viewModel.onTitle)
        }
    }

}
