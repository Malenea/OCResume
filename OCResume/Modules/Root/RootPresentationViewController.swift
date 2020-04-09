//
//  RootPresentationViewController.swift
//  OCResume
//
//  Created by Olivier Conan on 07/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

// MARK: Overrides and inits
final class RootPresentationViewController: BaseViewController {

    // View model
    private var rootPresentationViewModel: RootPresentationViewModel? {
        return viewModel as? RootPresentationViewModel
    }

    // Views and components
    private var darkModeButton: UIButton!
    private var timer: Timer?
    private var previousRandomColorIndex: Int?
    private var pulsatorContainerView: UIView!
    private var titleLabel: UILabel!
    private var instructionsLabel: UILabel!

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
private extension RootPresentationViewController {

    // Generic setup
    func setup() {
        setupViews()
    }

    // Setup of additional views
    func setupViews() {
        setupPulsatorContainerView()
        setupTitleLabel()
        setupInstructionsLabel()
        setupDarkModeButton()
    }

    func setupLayout() {
        setupPulsatorContainerViewLayout()
        setupTitleLabelLayout()
        setupInstructionsLabelLayout()
        setupDarkModeButtonLayout()
    }

    func setupGestures() {
        setupTap()
    }

    // Setting views
    func setupPulsatorContainerView() {
        // Creating view
        pulsatorContainerView = UIView()
        pulsatorContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pulsatorContainerView)
    }

    func setupTitleLabel() {
        guard let viewModel = rootPresentationViewModel else { return }

        // Creating view
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        // Setting view properties
        titleLabel.text = viewModel.title
        titleLabel.font = .title
        titleLabel.textColor = .getComponentColor()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        // Setting the alpha to 0 for initial animation
        titleLabel.alpha = 0.0
    }

    func setupInstructionsLabel() {
        guard let viewModel = rootPresentationViewModel else { return }

        // Creating view
        instructionsLabel = UILabel()
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructionsLabel)

        //Setting view properties
        instructionsLabel.text = viewModel.instructions
        instructionsLabel.font = .text
        instructionsLabel.textColor = .getComponentColor()
        instructionsLabel.textAlignment = .center
        instructionsLabel.numberOfLines = 0

        // Setting the alpha to 0 for initial animation
        instructionsLabel.alpha = 0.0
    }

    func setupDarkModeButton() {
        // Creating view
        darkModeButton = UIButton()
        darkModeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(darkModeButton)

        // Setting the alpha to 0 for initial animation
        darkModeButton.alpha = 0.0

        //Setting view properties
        darkModeButton.layer.cornerRadius = 24.0
        darkModeButton.backgroundColor = .getComponentColor()
        darkModeButton.addTarget(self, action: #selector(tappedOnButton), for: .touchUpInside)
    }

    func setupTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnScreen))
        tapGesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGesture)
    }

    // Setting each view's layout
    func setupPulsatorContainerViewLayout() {
        pulsatorContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pulsatorContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pulsatorContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pulsatorContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    func setupTitleLabelLayout() {
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
    }

    func setupInstructionsLabelLayout() {
        let bottomPadding = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0) + 16.0
        instructionsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomPadding).isActive = true
        instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    func setupDarkModeButtonLayout() {
        let topPadding = UIApplication.shared.statusBarFrame.height + 16.0
        darkModeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding).isActive = true
        darkModeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        darkModeButton.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        darkModeButton.widthAnchor.constraint(equalToConstant: 48.0).isActive = true
    }

    // setting gestures and buttons methods
    @objc func tappedOnButton(_ sender: UIButton) {
        let point = darkModeButton.center
        darkModeButton.flipBackgroundColor(to: .getBackgroundColor()) { [weak self] _ in
            self?.activatedDarkMode(from: point, completion: {
                guard let self = self else { return }
                UIView.transition(with: self.titleLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.titleLabel.textColor = .getComponentColor()
                    self.instructionsLabel.textColor = .getComponentColor()
                })
            })
        }
    }

    @objc func tappedOnScreen(_ sender: UITapGestureRecognizer) {
        // Creating the generator for the impact feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        timer?.invalidate()
        coordinator?.moveToMain()
    }

}

// MARK: Animation methods
extension RootPresentationViewController {

    func createRandomColor(with index: Int? = nil) -> UIColor {
        let colorArray: [UIColor] = UIColor.getPastelColors()
        let randomColorIndex = Int.random(in: 0...3)
        if let previousRandomColorIndex = previousRandomColorIndex, randomColorIndex == previousRandomColorIndex {
            return createRandomColor(with: randomColorIndex)
        }
        previousRandomColorIndex = randomColorIndex
        return colorArray[randomColorIndex].withAlphaComponent(0.5)
    }

    func startAnimating() {
        // Initial title and instructions labels animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            // Fade components in
            self?.titleLabel.fadeIn(with: 0.5)
            self?.instructionsLabel.fadeIn(with: 0.5)
            self?.darkModeButton.fadeIn(with: 0.5)

            // Add gestures
            self?.setupGestures()
        }

        // If timer exists we invalidate it
        if let timer = timer {
            timer.invalidate()
        }

        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { [weak self] _ in
            let randX = CGFloat.random(in: 0.0...(self?.view.frame.width ?? 0.0))
            let randY = CGFloat.random(in: 0.0...(self?.view.frame.height ?? 0.0))
            let point = CGPoint(x: randX, y: randY)
            let color = self?.createRandomColor().cgColor ?? .clear
            let width = self?.pulsatorContainerView.frame.width ?? 0.0
            self?.pulsatorContainerView.createPulsator(point: point, width: width, color: color, duration: 6.0)
        })
    }

}

extension RootPresentationViewController {

    override func reloadComponents() {
        super.reloadComponents()
    }

}
