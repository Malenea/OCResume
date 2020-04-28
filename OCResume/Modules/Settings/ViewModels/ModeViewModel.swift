//
//  ModeViewModel.swift
//  OCResume
//
//  Created by Olivier Conan on 28/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

class ModeViewModel: BaseViewModel {

    var title: String
    var onTitle: String
    var offTitle: String
    var color: UIColor

    init(title: String, onTitle: String, offTitle: String, color: UIColor) {
        self.title = title
        self.onTitle = onTitle
        self.offTitle = offTitle
        self.color = color
    }

}
