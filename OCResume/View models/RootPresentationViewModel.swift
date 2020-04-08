//
//  RootPresentationViewModel.swift
//  OCResume
//
//  Created by Olivier Conan on 07/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation

class RootPresentationViewModel: BaseViewModel {

    var title: String
    var instructions: String

    init(title: String, instructions: String) {
        self.title = title
        self.instructions = instructions
    }

}
