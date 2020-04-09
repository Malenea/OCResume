//
//  RootCoordinator.swift
//  Playground
//
//  Created by Olivier Conan on 11/03/2020.
//  Copyright © 2020 Medopad. All rights reserved.
//

import Foundation
import UIKit

// MARK: Init and initial methods
final class RootCoordinator: Coordinator {

    // Config handler
    let configHandler = ConfigHandler()

    // Coordinators and navigation controller
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    var presentedViewController: BaseViewController?

    // Start function
    func start() {
        let rootPresentationViewModel = RootPresentationViewModel(title: configHandler.getPresentationTitle(), instructions: configHandler.getPresentationInstructions())
        let vc = RootPresentationViewController(baseViewModel: rootPresentationViewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)

        vc.startAnimating()
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}

// MARK: General methods
extension RootCoordinator {

    func moveToMain() {
        let mainViewModel = MainViewModel(mainMenuButtons: configHandler.getMainMenuButtons())
        let vc = MainViewController(baseViewModel: mainViewModel)
        vc.coordinator = self
        navigationController.fadeTo(vc)
    }

}

// MARK: Main methods
extension RootCoordinator {

    func moveToSettings() {
        let settingsViewModel = SettingsViewModel(title: configHandler.getSettingsTitle())
        presentedViewController = SettingsViewController(baseViewModel: settingsViewModel)
        if let vc = presentedViewController {
            vc.coordinator = self
            navigationController.present(vc, animated: true, completion: nil)
        }
    }

    func dismissSettings() {
        if let vc = presentedViewController {
            vc.dismiss(animated: true, completion: nil)
        }
    }

}
