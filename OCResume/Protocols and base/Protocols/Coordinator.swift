//
//  Coordinator.swift
//  Playground
//
//  Created by Olivier Conan on 11/03/2020.
//  Copyright © 2020 Medopad. All rights reserved.
//

import Foundation
import UIKit

// MARK: Generic coordinator protocol
protocol Coordinator {

    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()

}
