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

extension RootCoordinator {

    func moveToMain() {
        let mainViewModel = MainViewModel(mainMenuButtons: configHandler.getMainMenuButtons())
        let vc = MainViewController(baseViewModel: mainViewModel)
        vc.coordinator = self
        navigationController.fadeTo(vc)
    }

}
