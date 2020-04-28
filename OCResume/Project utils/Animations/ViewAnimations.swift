//
//  ViewAnimations.swift
//  OCResume
//
//  Created by Olivier Conan on 07/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import UIKit

// Animations extensions
public extension UIView {

    func animatedCornerRadius(from start: CGFloat, to end: CGFloat, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.fromValue = start
        animation.toValue = end
        animation.duration = duration
        self.layer.add(animation, forKey: "cornerRadius")
        self.layer.cornerRadius = end
    }

    func animateBorderColor(toColor: UIColor, duration: Double) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = toColor.cgColor
        animation.duration = duration
        layer.add(animation, forKey: "borderColor")
        layer.borderColor = toColor.cgColor
    }

    func bounce() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { [weak self] _ in
            UIView.animate(withDuration: 0.2) {
                self?.transform = .identity
            }
        }
    }

    @discardableResult
    func fadeIn(with duration: TimeInterval, completion: ((Bool)->())? = nil) -> UIView {
        if duration <= .zero {
            self.alpha = 1.0
            return self
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        }) { status in
            if let completion = completion {
                completion(status)
            }
        }
        return self
    }

    @discardableResult
    func fadeOut(with duration: TimeInterval, completion: ((Bool)->())? = nil) -> UIView {
        if duration <= .zero {
            self.alpha = .zero
            return self
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = .zero
        }) { status in
            if let completion = completion {
                completion(status)
            }
        }
        return self
    }

    @discardableResult
    func shadowFadeIn(with duration: TimeInterval, completion: ((Bool)->())? = nil) -> UIView {
        if duration <= .zero {
            self.layer.shadowOpacity = 1.0
            return self
        }
        UIView.animate(withDuration: duration, animations: {
            self.layer.shadowOpacity = 1.0
        }) { status in
            if let completion = completion {
                completion(status)
            }
        }
        return self
    }

    @discardableResult
    func shadowFadeOut(with duration: TimeInterval, completion: ((Bool)->())? = nil) -> UIView {
        if duration <= .zero {
            self.layer.shadowOpacity = 0.0
            return self
        }
        UIView.animate(withDuration: duration,
                       animations: {
                        self.layer.shadowOpacity = 0.0
        }) { status in
            if let completion = completion {
                completion(status)
            }
        }
        return self
    }
    func flipBackgroundColor(to color: UIColor, completion: ((Bool)->())? = nil) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: self, duration: 0.5, options: transitionOptions, animations: {
            self.backgroundColor = color
        }) { status in
            completion?(status)
        }
    }

    func createPulsator(point: CGPoint, width: CGFloat, color: CGColor, isSolid: Bool = false, duration: TimeInterval = 0.5, completion: (()->())? = nil) {
        let pulsator = Pulsator()
        pulsator.position = CGPoint(x: point.x, y: point.y)
        pulsator.backgroundColor = color
        pulsator.radius = width
        pulsator.numPulse = 1
        pulsator.animationDuration = duration
        pulsator.repeatCount = 1
        pulsator.autoRemove = true

        pulsator.start(isSolid: isSolid)

        layer.addSublayer(pulsator)

        // The - 0.25 is to avoid any clipping in animation transition
        DispatchQueue.main.asyncAfter(deadline: .now() + duration - 0.25) {
            completion?()
        }
    }

}
