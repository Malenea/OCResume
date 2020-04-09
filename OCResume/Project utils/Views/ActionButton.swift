//
//  ActionButton.swift
//  OCResume
//
//  Created by Olivier Conan on 07/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import UIKit

// MARK: Protocols
public protocol ActionButtonDelegate: class {
    func didPress(_ actionButton: ActionButton) -> Void
}

public protocol ActionButtonDatasource: class {
    func titleForActionLabel(_ actionButton: ActionButton) -> String
}

// MARK: Overrides and inits
public class ActionButton: UIView {

    // Delegate and datasource refs
    public weak var actionButtonDelegate: ActionButtonDelegate?
    public weak var actionButtonDatasource: ActionButtonDatasource?

    // Identifier
    public var actionButtonIdentifier: String = "ActionButton"

    // Public title color
    public var actionButtonTitleColor: UIColor = .getComponentColor() {
        didSet {
            titleLabel.textColor = actionButtonTitleColor
        }
    }
    // TODO: Change once it's set on sheet
    public var actionButtonDisabledTitleColor: UIColor = .charcoalGray(0.2) {
        didSet {
            titleLabel.textColor = actionButtonDisabledTitleColor
        }
    }
    // Public title font
    public var actionButtonTitleFont: UIFont = .text {
        didSet {
            titleLabel.font = actionButtonTitleFont
        }
    }

    // Public background color
    public var actionButtonBackgroundColor: UIColor = .getBackgroundColor() {
        didSet {
            backgroundColor = actionButtonBackgroundColor
        }
    }
    // TODO: Change once it's set on sheet
    public var actionButtonDisabledBackgroundColor: UIColor = .charcoalGray(0.5) {
        didSet {
            backgroundColor = actionButtonDisabledBackgroundColor
        }
    }
    // Public border color
    public var actionButtonBorderColor: UIColor = .clear {
        didSet {
            layer.borderColor = actionButtonBorderColor.cgColor
        }
    }
    public var actionButtonDisabledBorderColor: CGColor = .clear {
        didSet {
            layer.borderColor = actionButtonBorderColor.cgColor
        }
    }
    // Public shadow
    public var isShadowed: Bool = false {
        didSet {
            if isShadowed {
                shadowFadeIn(with: 0.5)
            } else {
                shadowFadeOut(with: 0.5)
            }
        }
    }

    // Public pulsator customisation
    public var isPulsatorActivated: Bool = true
    public var pulsatorColor: UIColor = .getPulsatorColor()

    // Control and views variables
    public private(set) var isActive: Bool = true

    internal var titleLabel: UILabel!
    internal var imageView: UIImageView!
    internal var pulsatorView: UIView!

    override public init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        clipsToBounds = true
        layer.cornerRadius = 24.0
    }

}

public extension ActionButton {

    func addValues() {
        if let dataSource = self.actionButtonDatasource {
            titleLabel.text = dataSource.titleForActionLabel(self)
        }
    }

    func shrink() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.95,
                                               y: 0.95)
        }
    }

    func expand() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.transform = .identity
        }
    }

    func enable() {
        if self.isShadowed {
            shadowFadeIn(with: 0.5)
        }
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = self.actionButtonBackgroundColor
            self.layer.borderColor = self.actionButtonBorderColor.cgColor
            self.titleLabel.textColor = self.actionButtonTitleColor
        }
        isActive = true
    }

    func disable(active: Bool = false) {
        if self.isShadowed {
            shadowFadeOut(with: 0.5)
        }
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = self.actionButtonDisabledBackgroundColor
            self.layer.borderColor = self.actionButtonDisabledBorderColor
            self.titleLabel.textColor = self.actionButtonDisabledTitleColor
        }
        isActive = active
    }

    func select(completion: ((Bool)->())?) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .allowUserInteraction, animations: setActiveColors) { status in
            completion?(status)
        }
    }

    func deselect(completion: ((Bool)->())?) {
        UIView.animate(withDuration: 0.0, animations: setInactiveColors) { status in
            completion?(status)
        }
    }

    func changeTitleLabel(to title: String) {
        titleLabel.text = title
    }

    func updateTitleLabel() {
        if let dataSource = self.actionButtonDatasource {
            titleLabel.text = dataSource.titleForActionLabel(self)
        }
    }

    func getTitleLabel() -> String {
        if let title = titleLabel.text {
            return title
        }
        return ""
    }
}

// MARK: Setting up properties and views
internal extension ActionButton {

    func setup() {
        setupView()
        addViews()
        addLayout()

        addGesture()
    }

    func setupView() {
        backgroundColor = actionButtonBackgroundColor
        layer.borderWidth = 1.0
        layer.borderColor = actionButtonBorderColor.cgColor
        isUserInteractionEnabled = true
    }

    func addViews() {
        addtitleLabel()
        addImageView()
        addPulsatorView()
    }
}

// MARK: Adding views
extension ActionButton {

    func addtitleLabel() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        titleLabel.isUserInteractionEnabled = false

        titleLabel.textAlignment = .center
        titleLabel.textColor = actionButtonTitleColor
        titleLabel.font = actionButtonTitleFont
        titleLabel.numberOfLines = 0
    }

    func addImageView() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        imageView.isUserInteractionEnabled = false

        imageView.fadeOut(with: .zero)
    }

    func addPulsatorView() {
        pulsatorView = UIView()
        pulsatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pulsatorView)

        pulsatorView.isUserInteractionEnabled = false
    }

}

// MARK: Setting layouts for views
extension ActionButton {

    func addLayout() -> Void {
        // Title label constraints
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0).isActive = true

        // Image view constraints
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 16.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16.0).isActive = true

        // Pulsator view constraints
        pulsatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        pulsatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        pulsatorView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pulsatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

}

// MARK: Pulsator
extension ActionButton {

    func createPulsator() {
        let pulsator = Pulsator()
        pulsator.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        pulsator.backgroundColor = pulsatorColor.cgColor
        pulsator.radius = pulsatorView.frame.width
        pulsator.numPulse = 1
        pulsator.animationDuration = 1.0
        pulsator.repeatCount = 1
        pulsator.autoRemove = true

        pulsator.start()

        pulsatorView.layer.addSublayer(pulsator)
    }

}

// MARK: Adding gesture and action for gesture
extension ActionButton {

    func addGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(tappedOnButton))
        gesture.minimumPressDuration = 0.01
        addGestureRecognizer(gesture)
    }

    @objc func tappedOnButton(_ sender: UILongPressGestureRecognizer) -> Void {
        if !isActive { return }

        if sender.state == .began {
            shrink()
        } else if sender.state == .ended {

            // Creating the generator for the impact feedback
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()

            if isPulsatorActivated {
                createPulsator()
            }

            expand()

            let endY = sender.location(in: self).y
            if endY < frame.height && endY > 0 {
                if let delegate = actionButtonDelegate {
                    delegate.didPress(self)
                }
            }
        } else {
            expand()
        }
    }

}

extension ActionButton {

    func setInitialColors() {
        actionButtonBorderColor = .clear
        actionButtonBackgroundColor = .getBackgroundColor()
        actionButtonTitleColor = .getComponentColor()
    }

    func setActiveColors() {
        actionButtonBorderColor = .clear
        actionButtonBackgroundColor = .white
        actionButtonTitleColor = .charcoalGray
    }

    func setInactiveColors() {
        actionButtonBorderColor = .gray
        actionButtonBackgroundColor = .white
        actionButtonTitleColor = .charcoalGray
    }

    func setEnabledColours() {
        setInitialColors()
    }

    func setDisabledColors() {
        actionButtonBorderColor = .clear
        actionButtonBackgroundColor = .charcoalGray(0.5)
        actionButtonTitleColor = .charcoalGray(0.2)
    }

}
