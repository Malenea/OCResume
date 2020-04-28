//
//  MainViewModel.swift
//  OCResume
//
//  Created by Olivier Conan on 07/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import UIKit

// MARK: State enum
enum MainState: String {

    case home
    case profile
    case perks

}

struct MainMenuButton {

    var id: String
    var title: String
    var color: UIColor
    var type: MainState?

    init(id: String, title: String, color: UIColor, type: MainState?) {
        self.id = id
        self.title = title
        self.color = color
        self.type = type
    }

}

class MainViewModel: BaseViewModel {

    var mainMenuButtons: [MainMenuButton]

    init(mainMenuButtons: [MainMenuButton]) {
        self.mainMenuButtons = mainMenuButtons
    }

}
