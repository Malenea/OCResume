//
//  SettingsViewModel.swift
//  OCResume
//
//  Created by Olivier Conan on 09/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// MARK: Type enum
enum SettingsType: String {
    case mode
    case language
}

struct SettingsButton {

    var type: SettingsType?
    var index: Int
    var id: String
    var title: String
    var color: UIColor

    init(type: String, index: Int, id: String, title: String, color: UIColor) {
        self.type = SettingsType(rawValue: type)
        self.index = index
        self.id = id
        self.title = title
        self.color = color
    }

}

class SettingsViewModel: BaseViewModel {

    var title: String
    var settingsButtons: [SettingsButton]

    init(title: String, settingsButtons: [SettingsButton]) {
        self.title = title
        self.settingsButtons = settingsButtons
    }

}
