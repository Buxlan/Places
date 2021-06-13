//
//  OnboardingThirdViewController.swift
//  Places
//
//  Created by  Buxlan on 5/27/21.
//

import UIKit
import UserNotifications

class OnboardingThirdViewController: UIViewController, OnboardingProtocol {
    
    // MARK: - Public vars and properties
    var dismissAction: (() -> Void)!
    var futherAction: ((UIAction) -> Void)!
    
    // MARK: - UI objects
    
    private struct Strings {
        static let imageName = "logo"
        static let buttonLoginTitle = "Регистрация / Вход".localized()
        static let buttonBeginTitle = "Не сейчас".localized()
        static let titleText = "Познакомимся?".localized()
        static let appText = "Панорама".localized()
        static let description = "Регистрация и вход позволяют комментировать места и сохранять список любимых мест. Присоединяйтесь!".localized()
        static let userInfoName = "viewControllerIdentifier"
    }
    
    private lazy var appLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = Strings.appText
        label.textColor = .bxOrdinaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .bxAppTitle
        return label
    }()
    
    private lazy var dismissButton: UIButton = {

        let button = UIButton(type: .close)
        button.setTitleColor(.bxSecondaryLabel, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: Strings.imageName)
        let imageView = UIImageView(frame: .zero)
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = Strings.titleText
        label.textColor = .bxOrdinaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = .bxControlTitle
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = Strings.description
        label.textColor = .bxOrdinaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 7
        label.font = .bxBody
        return label
    }()
    
    private lazy var buttonLogin: UIButton = {
        let button = UIButton.onboardingButton(title: Strings.buttonLoginTitle,
                                               image: nil,
                                               action: UIAction(handler: loginAction))
        return button
    }()
    
    private lazy var buttonFuther: UIButton = {
        let button = UIButton.onboardingButton(title: Strings.buttonBeginTitle,
                                               image: nil,
                                               action: UIAction(handler: futherAction))
        button.titleLabel?.font = .bxBody
        button.backgroundColor = .clear
        button.setTitleColor(.bxSecondaryLabel, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 10)
        return button
    }()
    
    // MARK: - events and actions
    
    let loginAction: (UIAction) -> Void = { [self] (action) in
        NotificationCenter.default.post(name: .bxChangePage, object: nil, userInfo: [Strings.userInfoName : AppController.ViewControllerIdentifier.authLogin])
        Log(text: "Jumped to login view controller", object: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        // setup views
        view.addSubview(appLabel)
        view.addSubview(dismissButton)
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(textLabel)
        view.addSubview(buttonLogin)
        view.addSubview(buttonFuther)
        
        let constraints: [NSLayoutConstraint] = [
            
            appLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            appLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            
            dismissButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            dismissButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, constant: -50),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            
            textLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            textLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            
            buttonFuther.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonFuther.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            buttonLogin.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonLogin.bottomAnchor.constraint(equalTo: buttonFuther.topAnchor, constant: -10),
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    deinit {
        Utils.log("deinit OnboardingThirdViewController", object: self)
    }
    
    @objc
    private func dismissTapped() {
        dismissAction()
    }
    
}

extension NSNotification.Name {
    static let bxChangePage = NSNotification.Name("changePage")
}
