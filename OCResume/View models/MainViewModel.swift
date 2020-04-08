//
//  MainViewModel.swift
//  OCResume
//
//  Created by Olivier Conan on 07/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation

struct MainMenuButton {

    var id: String
    var title: String

    init(id: String, title: String) {
        self.id = id
        self.title = title
    }

}

class MainViewModel: BaseViewModel {

    var mainMenuButtons: [MainMenuButton]

    init(mainMenuButtons: [MainMenuButton]) {
        self.mainMenuButtons = mainMenuButtons
    }

}
