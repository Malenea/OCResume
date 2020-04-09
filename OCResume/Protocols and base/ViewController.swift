//
//  ViewController.swift
//  OCResume
//
//  Created by Olivier Conan on 07/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import UIKit
import CocoaLumberjack

protocol BaseViewControllerDarkModeHandler {

    func activatedDarkMode(from point: CGPoint, completion: (()->())?)
    func reloadComponents()

}

class BaseViewController: UIViewController {

    // Coordinator and view model
    weak var coordinator: RootCoordinator?
    let viewModel: BaseViewModel

    // Ref to native components of the base view
    var backgroundColor: UIColor = .getBackgroundColor()

    // Views and components
    var backgroundView: UIView!

    init(nibName: String? = nil, bundle: Bundle? = nil, baseViewModel: BaseViewModel) {
        viewModel = baseViewModel

        super.init(nibName: nibName, bundle: bundle)

        setupSelf()

        DDLogInfo("Initiated base view controller")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNativeViews()
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        setupNativeLayout()
    }

    deinit {
        DDLogInfo("De-initiated base view controller")
    }

    func setupSelf() {
    }

    func setupNativeViews() {
        setupBackgroundView()
    }

    func setupNativeLayout() {
        setupBackgroundViewLayout()
    }

    func setupBackgroundView() {
        // Creating view
        backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)

        // Setting view's properties
        backgroundView.backgroundColor = .getBackgroundColor()
    }

    func setupBackgroundViewLayout() {
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}

// Dark mode protocol
extension BaseViewController: BaseViewControllerDarkModeHandler {

    @objc func activatedDarkMode(from point: CGPoint, completion: (()->())? = nil) {
        let color: CGColor = .getPulsatorColor()
        backgroundView.createPulsator(point: point, width: view.frame.height, color: color, isSolid: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            darkMode = !darkMode
            self?.reloadComponents()
            completion?()
        }
    }

    @objc func reloadComponents() {
        backgroundView.backgroundColor = .getBackgroundColor()
    }

}
