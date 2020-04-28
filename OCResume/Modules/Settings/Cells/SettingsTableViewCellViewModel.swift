//
//  SettingsTableViewCellViewModel.swift
//  OCResume
//
//  Created by Olivier Conan on 15/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableViewCellViewModel: BaseViewModel {

    var button: SettingsButton

    init(button: SettingsButton) {
        self.button = button
    }

}
