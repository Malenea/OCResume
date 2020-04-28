//
//  ViewControllerAnimations.swift
//  OCResume
//
//  Created by Olivier Conan on 08/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import UIKit

// Animations extensions
extension UINavigationController {

    func fadeTo(_ viewController: UIViewController, completion: (()->())? = nil) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion?()
        }
    }

}
