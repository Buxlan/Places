//
//  OnboardingThirdViewController.swift
//  Places
//
//  Created by  Buxlan on 5/27/21.
//

import UIKit
import UserNotifications

import UIKit

class OnboardingThirdViewController: UIViewController {
    
    // MARK: - public properties and methods
    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UI objects
    private weak var coordinator: OnboardingCoordinator?
    
    private lazy var logo: UILabel = {
        let label = UILabel()
        label.text = L10n.Onboarding.logo
//        label.font = UIFont(name: <#T##String#>, size: <#T##CGFloat#>)
        label.textColor = Asset.darkText.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .bxControlTitle
        return label
    }()
    
    private lazy var dismissButton: UIButton = {
        let view = UIButton()
        view.setImage(Asset.xmark.image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(coordinator, action: #selector(OnboardingCoordinator.dismissTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let image = Asset.onboarding3.image
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Onboarding.welcomeLogin
        label.textColor = Asset.darkText.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .bxControlTitle
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Onboarding.loginDescription
        label.textColor = Asset.darkText.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 10
        label.font = .bxBody
        return label
    }()
    
    private lazy var buttonFuther: OnboardingFutherButton = {
        let button = OnboardingFutherButton(title: L10n.Onboarding.Buttons.login,
                                      image: nil)
        button.addTarget(coordinator, action: #selector(OnboardingCoordinator.futherTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonSkip: OnboardingSkipButton = {
        let button = OnboardingSkipButton(title: L10n.Onboarding.Buttons.later,
                                      image: nil)
        button.addTarget(coordinator, action: #selector(OnboardingCoordinator.dismissTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - events and actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Asset.background.color
        
        view.addSubview(logo)
        view.addSubview(dismissButton)
        
        // Image view
        view.addSubview(imageView)
        
        // Tittle and text
        view.addSubview(titleLabel)
        view.addSubview(textLabel)
        
        // Buttons
        view.addSubview(buttonFuther)
        view.addSubview(buttonSkip)
        
        let constraints: [NSLayoutConstraint] = [
            
            logo.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,
                                               constant: 8),
            logo.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
                        
            dismissButton.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            dismissButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 18),
            dismissButton.heightAnchor.constraint(equalTo: dismissButton.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                             constant: -32),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                              constant: -32),

            textLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            textLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                             constant: -32),
            
            buttonFuther.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonFuther.bottomAnchor.constraint(equalTo: buttonSkip.topAnchor,
                                                 constant: -8),
            
            buttonSkip.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonSkip.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                                 constant: -8),
            buttonSkip.widthAnchor.constraint(equalTo: buttonFuther.widthAnchor),
            buttonSkip.heightAnchor.constraint(equalTo: buttonFuther.heightAnchor)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }

}


