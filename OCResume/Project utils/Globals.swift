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

//
struct SupportedLanguages {

    static let english = "en"
    static let french = "fr"

}

// Get locale language to default app
let locale: String = {
    if let locale = UserDefaults.standard.string(forKey: "locale") {
        return locale
    }
    if let locale = Locale.current.languageCode {
        switch locale {
        case SupportedLanguages.english:
            UserDefaults.standard.set(SupportedLanguages.english, forKey: "locale")
            return locale
        case SupportedLanguages.french:
            UserDefaults.standard.set(SupportedLanguages.french, forKey: "locale")
            return locale
        default:
            return SupportedLanguages.english
        }
    }
    return SupportedLanguages.english
}()

// iOS 13 is used to know the present mode so we can add revelant componants when needed
let isIOS13: Bool = {
    if #available(iOS 13.0, *) {
        return true
    } else {
        return false
    }
}()
