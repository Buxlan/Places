//
//  OnboardingFirstViewController.swift
//  Places
//
//  Created by  Buxlan on 5/27/21.
//

import UIKit

class OnboardingFirstViewController: UIViewController {
    
    // MARK: - public properties and methods
    weak var delegate: OnboardingViewControllerDelegate?
    
    // MARK: - used strings
    private struct Strings {
        static let titleString = "Добро пожаловать!".localized()
        static let textString = """
Мы рады приветствовать Вас в Панораме.
Здесь мы делимся собственными мыслями и воспоминаниями о любимых местах города.
""".localized()
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
        label.font = .bxAppTitle
        return label
    }()
    
    private lazy var dismissButton: UIButton = {

        let button = UIButton()
        button.setImage(.closeIcon, for: .normal)
        button.setTitleColor(.bxSecondaryText, for: .normal)
        button.titleLabel?.font = .bxAppTitle
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(delegate, action: #selector(OnboardingViewControllerDelegate.dismissTapped), for: .touchUpInside)
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
        label.textColor = .bxDarkText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .bxControlTitle
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = Strings.textString
        label.textColor = .bxDarkText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 10
        label.font = .bxBody
        return label
    }()
    
    private lazy var buttonFuther: UIButton = {
        let button = UIButton.onboardingButton(
            title: Strings.buttonText,
            image: nil)
        button.addTarget(delegate, action: #selector(OnboardingViewControllerDelegate.buttonFutherTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - events and actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .bxBackground
        
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
//        view.addSubview(buttonFuther1)
        
        let constraints: [NSLayoutConstraint] = [
            
            appLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            appLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,
                                          constant: 10),
            
            dismissButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,
                                               constant: 10),
            dismissButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                              constant: -50),
            imageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                             constant: -50),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                              constant: -50),

            textLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            textLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                             constant: -50),
            
            buttonFuther.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonFuther.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                                 constant: -10)
//
//            buttonFuther1.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
//            buttonFuther1.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    deinit {
        Utils.log("Deinit", object: self)
    }
}
