//
//  PresentedSettingsNavigationViewController.swift
//  OCResume
//
//  Created by Olivier Conan on 09/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

class PresentedSettingsNavigationViewController: UINavigationController, UIAdaptivePresentationControllerDelegate {

    // Coordinator and view model
    weak var coordinator: RootCoordinator?

    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .getBackgroundColor()
        presentationController?.delegate = self
    }

    // Presentation dismiss trigger
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        for viewController in viewControllers {
            viewController.removeFromParent()
        }
        coordinator?.didDismissSettings()
    }

}
