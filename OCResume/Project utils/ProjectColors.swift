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

    // Content colors
    class var pastelOrange: UIColor {
        return UIColor(red: 1.0, green: 0.85, blue: 0.76, alpha: 1.00)
    }

    class func pastelOrange(_ alpha: CGFloat) -> UIColor {
        return pastelOrange.withAlphaComponent(alpha)
    }

    class var pastelGreen: UIColor {
        return UIColor(red: 0.89, green: 0.94, blue: 0.8, alpha: 1.0)
    }

    class func pastelGreen(_ alpha: CGFloat) -> UIColor {
        return pastelGreen.withAlphaComponent(alpha)
    }

    class var pastelMint: UIColor {
        return UIColor(red: 0.71, green: 0.92, blue: 0.84, alpha: 1.0)
    }

    class func pastelMint(_ alpha: CGFloat) -> UIColor {
        return pastelMint.withAlphaComponent(alpha)
    }

    class var pastelBlue: UIColor {
        return UIColor(red: 0.78, green: 0.81, blue: 0.92, alpha: 1.0)
    }

    class func pastelBlue(_ alpha: CGFloat) -> UIColor {
        return pastelBlue.withAlphaComponent(alpha)
    }

    class func getPastelColors() -> [UIColor] {
        return [pastelOrange, pastelGreen, pastelMint, pastelBlue]
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

    class func getSecondary() -> UIColor {
        return darkMode ? primaryLight : primaryDark
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

    class var white: CGColor {
        return UIColor.white.cgColor
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

    // Content colors
    class var pastelOrange: CGColor {
        return UIColor.pastelOrange.cgColor
    }

    class func pastelOrange(_ alpha: CGFloat) -> CGColor {
        return UIColor.pastelOrange.withAlphaComponent(alpha).cgColor
    }

    class var pastelGreen: CGColor {
        return UIColor.pastelGreen.cgColor
    }

    class func pastelGreen(_ alpha: CGFloat) -> CGColor {
        return UIColor.pastelGreen.withAlphaComponent(alpha).cgColor
    }

    class var pastelMint: CGColor {
        return UIColor.pastelMint.cgColor
    }

    class func pastelMint(_ alpha: CGFloat) -> CGColor {
        return UIColor.pastelMint.withAlphaComponent(alpha).cgColor
    }

    class var pastelBlue: CGColor {
        return UIColor.pastelBlue.cgColor
    }

    class func pastelBlue(_ alpha: CGFloat) -> CGColor {
        return UIColor.pastelBlue.withAlphaComponent(alpha).cgColor
    }

    // Component color
    class var componentColorDark: CGColor {
        return offWhite
    }

    class func componentColorDark(_ alpha: CGFloat) -> CGColor {
        return UIColor.componentColorDark.withAlphaComponent(alpha).cgColor
    }

    class var componentColorLight: CGColor {
        return UIColor.charcoalGray.cgColor
    }

    class func componentColorLight(_ alpha: CGFloat) -> CGColor {
        return UIColor.componentColorLight.withAlphaComponent(alpha).cgColor
    }

    class func getComponentColor() -> CGColor {
        darkMode ? componentColorDark : componentColorLight
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

    // Background color
    class var backgroundColorDark: CGColor {
        return UIColor.primaryDark.cgColor
    }

    class func backgroundColorDark(_ alpha: CGFloat) -> CGColor {
        return UIColor.backgroundColorDark.withAlphaComponent(alpha).cgColor
    }

    class var backgroundColorLight: CGColor {
        return UIColor.primaryLight.cgColor
    }

    class func backgroundColorLight(_ alpha: CGFloat) -> CGColor {
        return UIColor.backgroundColorLight.withAlphaComponent(alpha).cgColor
    }

    class func getBackgroundColor() -> CGColor {
        return darkMode ? backgroundColorDark : backgroundColorLight
    }

}
