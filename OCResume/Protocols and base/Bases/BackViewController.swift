//
//  BackViewController.swift
//  OCResume
//
//  Created by Olivier Conan on 28/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

class BackBaseViewController: BaseViewController {

    // Views and components
    var borderView: UIView!
    var cacheView: UIView!
    var topHeader: UIView!
    var backButton: UIButton!
    var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupForPrevViews()
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        setupForPrevLayout()
    }

}

extension BackBaseViewController {

    func createRectForBorder(rect: CGRect, index: Int) {
        let frame = CGRect(origin: CGPoint(x: 0.0, y: rect.minY + 4.0), size: CGSize(width: 1.0, height: rect.height - 8.0))
        cacheView = UIView(frame: frame)
        cacheView.backgroundColor = .getBackgroundColor()
        view.addSubview(cacheView)
    }

}

extension BackBaseViewController {

    func setupForPrevViews() {
        setupBorderView()
        setupTopHeader()
        setupBackButton()
        setupTitleLabel()
    }

    func setupForPrevLayout() {
        setupBorderViewLayout()
        setupTopHeaderLayout()
        setupBackButtonLayout()
        setupTitleLabelLayout()
    }

    // MARK: Setting views
    func setupBorderView() {
        // Creating view
        borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(borderView)

        // Setting view properties
        borderView.layer.cornerRadius = 11.0
        borderView.layer.borderWidth = 1.0
        borderView.layer.borderColor = .clear
    }

    func setupTopHeader() {
        // Creating view
        topHeader = UIView()
        topHeader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topHeader)
    }

    func setupBackButton() {
        // Creating view
        backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        topHeader.addSubview(backButton)

        // Setting view properties
        let padding = PPaddings.basicPadding
        backButton.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        backButton.layer.cornerRadius = 24.0
        backButton.backgroundColor = .clear
    }

    func setupTitleLabel() {
        // Creating view
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        topHeader.addSubview(titleLabel)

        // Setting view properties
        titleLabel.font = .title
    }

    //MARK: Setting each view's layout
    func setupBorderViewLayout() {
        let topPadding = isIOS13 ? 0.0 : UIApplication.shared.statusBarFrame.height
        borderView.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding).isActive = true
        borderView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: PPaddings.interPadding).isActive = true
        borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        borderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    func setupTopHeaderLayout() {
        let topPadding = (isIOS13 ? 0.0 : UIApplication.shared.statusBarFrame.height)
        let height = topPadding + PPaddings.componentPadding + PPaddings.interPadding
        topHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: PPaddings.interPadding).isActive = true
        topHeader.heightAnchor.constraint(equalToConstant: height).isActive = true
        topHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    func setupBackButtonLayout() {
        let topPadding = (isIOS13 ? 0.0 : UIApplication.shared.statusBarFrame.height) + PPaddings.interPadding
        backButton.topAnchor.constraint(equalTo: topHeader.topAnchor, constant: topPadding).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topHeader.leadingAnchor, constant: PPaddings.interPadding).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: PPaddings.componentPadding).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: PPaddings.componentPadding).isActive = true
    }

    func setupTitleLabelLayout() {
        let topPadding = (isIOS13 ? 0.0 : UIApplication.shared.statusBarFrame.height) + PPaddings.interPadding
        titleLabel.topAnchor.constraint(equalTo: topHeader.topAnchor, constant: topPadding).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: topHeader.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: PPaddings.interPadding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: topHeader.trailingAnchor, constant: -PPaddings.interPadding).isActive = true
    }

    // MARK: Setting gestures and buttons methods
    @objc func tappedOnBackButton(_ sender: UIButton) {
        // Creating the generator for the impact feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

}
