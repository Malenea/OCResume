//
//  TableViewCell.swift
//  OCResume
//
//  Created by Olivier Conan on 15/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// Protocol
protocol SingleTableViewCellDelegate: class {

    func didTapOnSingleTableViewCell(_ singleTableViewCell: SingleTableViewCell)

}

// MARK: Inits
class SingleTableViewCell: UITableViewCell {

    // Delegate
    public weak var delegate: SingleTableViewCellDelegate?

    // Gesture
    private var tapGesture: UILongPressGestureRecognizer!

    // Cell color
    var color: UIColor = .clear
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SingleTableViewCell {

    @objc func setup() {
        setupSelf()
    }

    @objc func setupSelf() {
        backgroundColor = .clear

        selectionStyle = .none

        clipsToBounds = true
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = .clear
        contentView.backgroundColor = .white

        setupGesture()
    }

    func setupGesture() {
        tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(tappedOnCell))
        tapGesture.minimumPressDuration = 0.0
        contentView.addGestureRecognizer(tapGesture)
    }

    @objc func tappedOnCell(_ sender: UILongPressGestureRecognizer) {
        let state = sender.state
        switch state {
        case .began:
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        case .ended:
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.transform = .identity
            }
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            delegate?.didTapOnSingleTableViewCell(self)
        default:
            break
        }
    }

    @objc func animate(with duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.contentView.layer.borderColor = self?.color.cgColor
        }
    }

}
