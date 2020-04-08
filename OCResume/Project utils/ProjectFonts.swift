//
//  ProjectFonts.swift
//  OCResume
//
//  Created by Olivier Conan on 07/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import UIKit

// MARK: UIColor extensions
public extension UIFont {

    class var title: UIFont {
        return UIFont.systemFont(ofSize: 40.0, weight: .heavy)
    }

    class var text: UIFont {
        return UIFont.systemFont(ofSize: 12.0, weight: .regular)
    }

}
