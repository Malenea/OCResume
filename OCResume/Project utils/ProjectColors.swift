//
//  ProjectColors.swift
//  OCResume
//
//  Created by Olivier Conan on 07/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import UIKit

// MARK: UIColor extensions
public extension UIColor {

    class var charcoalGray: UIColor {
        return UIColor(red: 0.18, green: 0.19, blue: 0.20, alpha: 1.00)
    }

    class func charcoalGray(_ alpha: CGFloat) -> UIColor {
        return charcoalGray.withAlphaComponent(alpha)
    }

    class var offWhite: UIColor {
        return UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
    }

    class func offWhite(_ alpha: CGFloat) -> UIColor {
        return offWhite.withAlphaComponent(alpha)
    }

    // These are the colours to be used in conjonction with the app's 'dark mode'
    // Primary color in general
    class var primaryDark: UIColor {
        return charcoalGray
    }

    class func primaryDark(_ alpha: CGFloat) -> UIColor {
        return primaryDark.withAlphaComponent(alpha)
    }

    class var primaryLight: UIColor {
        return offWhite
    }

    class func primaryLight(_ alpha: CGFloat) -> UIColor {
        return primaryLight.withAlphaComponent(alpha)
    }

    class func getPrimary() -> UIColor {
        return darkMode ? primaryDark : primaryLight
    }

    // Component color
    class var componentColorDark: UIColor {
        return offWhite
    }

    class func componentColorDark(_ alpha: CGFloat) -> UIColor {
        return componentColorDark.withAlphaComponent(alpha)
    }

    class var componentColorLight: UIColor {
        return charcoalGray
    }

    class func componentColorLight(_ alpha: CGFloat) -> UIColor {
        return componentColorLight.withAlphaComponent(alpha)
    }

    class func getComponentColor() -> UIColor {
        darkMode ? componentColorDark : componentColorLight
    }

    // Pulsator color
    class var pulsatorColorDark: UIColor {
        return offWhite
    }

    class func pulsatorColorDark(_ alpha: CGFloat) -> UIColor {
        return pulsatorColorDark.withAlphaComponent(alpha)
    }

    class var pulsatorColorLight: UIColor {
        return charcoalGray
    }

    class func pulsatorColorLight(_ alpha: CGFloat) -> UIColor {
        return pulsatorColorLight.withAlphaComponent(alpha)
    }

    class func getPulsatorColor() -> UIColor {
        return darkMode ? pulsatorColorDark : pulsatorColorLight
    }

    // Background color
    class var backgroundColorDark: UIColor {
        return primaryDark
    }

    class func backgroundColorDark(_ alpha: CGFloat) -> UIColor {
        return backgroundColorDark.withAlphaComponent(alpha)
    }

    class var backgroundColorLight: UIColor {
        return primaryLight
    }

    class func backgroundColorLight(_ alpha: CGFloat) -> UIColor {
        return backgroundColorLight.withAlphaComponent(alpha)
    }

    class func getBackgroundColor() -> UIColor {
        return darkMode ? backgroundColorDark : backgroundColorLight
    }

}

// MARK: CGColor extensions
public extension CGColor {

    class var clear: CGColor {
        return UIColor.clear.cgColor
    }

    class var charcoalGray: CGColor {
        return UIColor.charcoalGray.cgColor
    }

    class func charcoalGray(_ alpha: CGFloat) -> CGColor {
        return UIColor.charcoalGray.withAlphaComponent(alpha).cgColor
    }

    class var offWhite: CGColor {
        return UIColor.offWhite.cgColor
    }

    class func offWhite(_ alpha: CGFloat) -> CGColor {
        return UIColor.offWhite.withAlphaComponent(alpha).cgColor
    }

    // Pulsator color
    class var pulsatorColorDark: CGColor {
        return UIColor.pulsatorColorDark.cgColor
    }

    class func pulsatorColorDark(_ alpha: CGFloat) -> CGColor {
        return UIColor.pulsatorColorDark.withAlphaComponent(alpha).cgColor
    }

    class var pulsatorColorLight: CGColor {
        return UIColor.pulsatorColorLight.cgColor
    }

    class func pulsatorColorLight(_ alpha: CGFloat) -> CGColor {
        return UIColor.pulsatorColorLight.withAlphaComponent(alpha).cgColor
    }

    class func getPulsatorColor() -> CGColor {
        return darkMode ? pulsatorColorDark : pulsatorColorLight
    }

}
