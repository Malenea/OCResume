//
//  ProjectPaddings.swift
//  OCResume
//
//  Created by Olivier Conan on 07/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import UIKit

// MARK: Project paddings
struct ProjectPaddings {

    public static let statusBarPadding = UIApplication.shared.statusBarFrame.height
    public static let bottomBarPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0

}
