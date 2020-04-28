//
//  PresentedViewController.swift
//  OCResume
//
//  Created by Olivier Conan on 09/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

class PresentedBaseViewController: BaseViewController {

    // Views and components
    var topHeader: UIView!
    var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupForPrevViews()
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        setupForPrevLayout()
    }

    func setupForPrevViews() {
        setupTopHeader()
        if !isIOS13 {
            setupCloseButton()
        }
    }

    func setupForPrevLayout() {
        setupTopHeaderLayout()
        if !isIOS13 {
            setupCloseButtonLayout()
        }
    }

    // Setting views
    func setupTopHeader() {
        // Creating view
        topHeader = UIView()
        topHeader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topHeader)
    }

    func setupCloseButton() {
        // Creating view
        closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        topHeader.addSubview(closeButton)

        // Setting view properties
        closeButton.layer.cornerRadius = 24.0
        closeButton.setImage(UIImage(named: "ic_down")?.maskWithColor(color: .getComponentColor()), for: .normal)
        let padding = PPaddings.basicPadding
        closeButton.imageEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }

    // Setting each view's layout
    func setupTopHeaderLayout() {
        let topPadding = UIApplication.shared.statusBarFrame.height
        let height = isIOS13 ? 0.0 : topPadding + PPaddings.componentPadding + PPaddings.interPadding
        topHeader.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topHeader.heightAnchor.constraint(equalToConstant: height).isActive = true
        topHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    func setupCloseButtonLayout() {
        let topPadding = UIApplication.shared.statusBarFrame.height
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding + PPaddings.interPadding).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PPaddings.interPadding).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: PPaddings.componentPadding).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: PPaddings.componentPadding).isActive = true
    }

}
