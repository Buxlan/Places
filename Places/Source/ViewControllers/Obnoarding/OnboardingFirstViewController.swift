//
//  OnboardingFirstViewController.swift
//  Places
//
//  Created by  Buxlan on 5/27/21.
//

import UIKit

class OnboardingFirstViewController: UIViewController, OnboardingProtocol {
    
    // MARK: - public properties and methods
    var dismissAction: (() -> Void)!
    var futherAction: ((UIAction) -> Void)!
    
    // MARK: - used strings
    private struct Strings {
        static let titleString = "Добро пожаловать!".localized()
        static let textString = "Мы рады приветствовать Вас в Панораме. Здесь мы делимся собственными мыслями и воспоминаниями о любимых местах города.".localized()
        static let appString = "Панорама".localized()
        static let buttonText = "Далее (1 из 3)".localized()
        
        static let imageName = "onboarding1"
    }

    // MARK: - UI objects
    
    private lazy var appLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = Strings.appString
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private lazy var dismissButton: UIButton = {

        let button = UIButton(type: .close)
        button.setTitleColor(.secondaryLabel, for: .normal)
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
        label.text = Strings.titleString
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = Strings.textString
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 7
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    private lazy var buttonFuther: UIButton = {
        let button = UIButton.onboardingButton(
            title: Strings.buttonText,
            image: nil,
            action: UIAction(handler: futherAction))
        return button
    }()
    
    // MARK: - events and actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        // Application title
        view.addSubview(appLabel)
        view.addSubview(dismissButton)
        
        // Image view
        view.addSubview(imageView)
        
        // Tittle and text
        view.addSubview(titleLabel)
        view.addSubview(textLabel)
        
        // Button Futher
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
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, constant: -50),

            textLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            textLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, constant: -50),
            
            buttonFuther.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonFuther.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private lazy var nextButtonAction = UIAction() { action in
        guard let parent = self.parent as? OnboardingViewController else {
            fatalError()
        }
        parent.nextPage(viewControllerBefore: self)
    }
    
    deinit {
        Utils.log("Deinit", object: self)
    }
    
    @objc
    private func dismissTapped() {
        dismissAction?()
    }
        
    
}
