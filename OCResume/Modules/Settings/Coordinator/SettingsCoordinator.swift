//
//  SettingsCoordinator.swift
//  OCResume
//
//  Created by Olivier Conan on 09/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// MARK: Init and initial methods
final class SettingsCoordinator: Coordinator {

    // Parent coordinator
    weak var coordinator: RootCoordinator?

    // Coordinators and navigation controller
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    // Start function
    func start() {
        guard let coordinator = coordinator else { return }
        let settingsViewModel = SettingsViewModel(title: coordinator.configHandler.getSettingsTitle(), settingsButtons: coordinator.configHandler.getSettingsButtons())
        let vc = SettingsViewController(baseViewModel: settingsViewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    // MARK: Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}

extension SettingsCoordinator {

    func moveBackToSettings() {
        navigationController.popViewController(animated: true)
    }

    func updateSettings() {
        coordinator?.updateMain()
        if let settingsVC = navigationController.viewControllers.first as? SettingsViewController {
            settingsVC.reloadView()
        }
    }

}

extension SettingsCoordinator {

    func moveToTest(button: SettingsButton, color: UIColor, rect: CGRect = .zero) {
        guard let type = button.type else { return }
        switch type {
        case .mode:
            let modeViewModel = ModeViewModel(title: button.title, onTitle: "", offTitle: "", color: color)
            let vc = ModeViewController(baseViewModel: modeViewModel)
            vc.coordinator = self
            vc.createRectForBorder(rect: rect, index: button.index + 1)
            navigationController.pushViewController(vc, animated: true)
        case .language:
            let modeViewModel = LanguageViewModel(title: button.title, color: color)
            let vc = LanguageViewController(baseViewModel: modeViewModel)
            vc.coordinator = self
            vc.createRectForBorder(rect: rect, index: button.index + 1)
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
}

extension SettingsCoordinator {

    func dismiss() {
        coordinator?.dismissSettings()
    }

}
