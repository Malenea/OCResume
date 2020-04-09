//
//  Globals.swift
//  OCResume
//
//  Created by Olivier Conan on 08/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation

// I created a distinct dark mode from the phone's one because I wanted the app
// to default to dark mode in all situations.
// In short, this is more of a 'Do you want to use light mode?'
var darkMode: Bool = true

// iOS 13 is used to know the present mode so we can add revelant componants when needed
let isIOS13: Bool = {
    if #available(iOS 13.0, *) {
        return true
    } else {
        return false
    }
}()
