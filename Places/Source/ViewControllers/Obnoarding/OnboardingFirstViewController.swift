//
//  OnboardingFirstViewController.swift
//  Places
//
//  Created by  Buxlan on 5/27/21.
//

import UIKit

class OnboardingFirstViewController: UIViewController {
    
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
        let view = UILabel()
        view.text = L10n.App.name
//        label.font = UIFont(name: <#T##String#>, size: <#T##CGFloat#>)
        view.textColor = Asset.darkText.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = .bxControlTitle
        return view
    }()
    
    private lazy var dismissButton: UIButton = {
        let view = UIButton()
        view.setImage(Asset.xmark.image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(coordinator, action: #selector(OnboardingCoordinator.dismiss), for: .touchUpInside)
        return view
    }()
    
    private lazy var imageView: UIView = {
        
        let image = Asset.onboarding1.image
        
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowRadius = 50
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 12, height: 12)
        view.layer.shadowColor = Asset.darkText.color.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
                        
        let imageView = UIImageView()
        imageView.image = image
        imageView.backgroundColor = Asset.background.color
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(imageView)
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = L10n.Onboarding.welcome
        view.textColor = Asset.darkText.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = .bxControlTitle
        return view
    }()
    
    private lazy var textView: UILabel = {

        let view = UILabel()
        view.text = L10n.Onboarding.welcomeDescription
        view.textColor = Asset.darkText.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        view.font = .bxBody
        
        return view
        
    }()
        
    private lazy var buttonFuther: ButtonWithShadow = {
        let view = ButtonWithShadow(title: L10n.Onboarding.Buttons.futher1,
                                            image: nil)
        view.addTarget(coordinator, action: #selector(OnboardingCoordinator.futher), for: .touchUpInside)        
        return view
    }()
    
    private lazy var buttonSkip: OnboardingSkipButton = {
        let button = OnboardingSkipButton(title: L10n.Onboarding.Buttons.skip,
                                      image: nil)
        button.addTarget(coordinator, action: #selector(OnboardingCoordinator.dismiss), for: .touchUpInside)
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
        view.addSubview(textView)
        
        // Buttons
        view.addSubview(buttonFuther)
        view.addSubview(buttonSkip)
        
        let constraints: [NSLayoutConstraint] = [
            
            logo.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,
                                               constant: 8),
            logo.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
                        
            dismissButton.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            dismissButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 16),
            dismissButton.heightAnchor.constraint(equalTo: dismissButton.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                             constant: -32),
            imageView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -8),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                              constant: -32),

            textView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            textView.bottomAnchor.constraint(equalTo: buttonFuther.topAnchor, constant: -8),
            textView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                             constant: -32),
            
            buttonFuther.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonFuther.bottomAnchor.constraint(equalTo: buttonSkip.topAnchor,
                                                 constant: -8),
            buttonFuther.heightAnchor.constraint(equalToConstant: 44),
            
            buttonSkip.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonSkip.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                                 constant: -8),
            buttonSkip.widthAnchor.constraint(equalTo: buttonFuther.widthAnchor),
            buttonSkip.heightAnchor.constraint(equalTo: buttonFuther.heightAnchor)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
