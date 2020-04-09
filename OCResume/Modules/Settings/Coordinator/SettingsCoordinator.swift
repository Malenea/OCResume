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

    var presentedViewController: BaseViewController?

    // Start function
    func start() {
        let settingsViewModel = SettingsViewModel(title: coordinator?.configHandler.getSettingsTitle() ?? "")
        let vc = SettingsViewController(baseViewModel: settingsViewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}

extension SettingsCoordinator {

    func dismiss() {
        coordinator?.dismissSettings()
    }

}
