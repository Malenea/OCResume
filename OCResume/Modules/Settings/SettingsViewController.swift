//
//  SettingsViewController.swift
//  OCResume
//
//  Created by Olivier Conan on 09/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// MARK: Overrides and inits
class SettingsViewController: PresentedBaseViewController {

    // View model
    private var mainViewModel: SettingsViewModel? {
        return viewModel as? SettingsViewModel
    }

    // Views and components

    // Inits
    override init(nibName: String? = nil, bundle: Bundle? = nil, baseViewModel: BaseViewModel) {
        super.init(baseViewModel: baseViewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        setupLayout()
    }

}

// MARK: Views creations and setups
extension SettingsViewController {

    func setup() {
        if !isIOS13 {
            addCloseButtonTarget()
        }
    }

    func setupLayout() {
    }

    // setting gestures and buttons methods
    func addCloseButtonTarget() {
        closeButton.addTarget(self, action: #selector(tappedOnCloseButton), for: .touchUpInside)
    }
    
    @objc func tappedOnCloseButton(_ sender: UIButton) {
        coordinator?.dismissSettings()
    }

}
