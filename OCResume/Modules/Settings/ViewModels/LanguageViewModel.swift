//
//  LanguageViewModel.swift
//  OCResume
//
//  Created by Olivier Conan on 28/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

class LanguageViewModel: BaseViewModel {

    var title: String
    var color: UIColor

    init(title: String, color: UIColor) {
        self.title = title
        self.color = color
    }

}
