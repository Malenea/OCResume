//
//  SettingsTableViewCell.swift
//  OCResume
//
//  Created by Olivier Conan on 15/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// MARK: Overrides, inits and bind
class SettingsTableViewCell: SingleTableViewCell, DarkProtocol {

    //Dark protocol
    func reloadView() {
        titleLabel.textColor = darkMode ? .white : .charcoalGray
    }

    // View model
    private(set) var settingsTableViewCellViewModel: SettingsTableViewCellViewModel?

    // Views and components
    private var titleLabel: UILabel!

    // Override methods
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4.0, left: 0.0, bottom: 4.0, right: 0.0))
    }

    override func animate(with duration: TimeInterval = 0.5) {
        super.animate()

        titleLabel.fadeIn(with: 0.5)
    }

    // Bind method to provide the view model
    func bind(viewModel: SettingsTableViewCellViewModel) {
        self.settingsTableViewCellViewModel = viewModel

        color = viewModel.button.color

        setup()
    }

}

// MARK: Views creations and setups
extension SettingsTableViewCell {

    // Generic setup
    override func setup() {
        setupSelf()
        setupViews()
    }

    override func setupSelf() {
        super.setupSelf()

        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = PPaddings.componentCornerRadiusPadding
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }

    // Setup of additional views
    func setupViews() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        titleLabel.textColor = darkMode ? .white : .charcoalGray
        titleLabel.font = .headline
        titleLabel.text = settingsTableViewCellViewModel?.button.title

        titleLabel.alpha = 0.0

        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PPaddings.interPadding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PPaddings.interPadding).isActive = true
    }

}
