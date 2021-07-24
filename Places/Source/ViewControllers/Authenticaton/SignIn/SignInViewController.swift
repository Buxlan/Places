//
//  SignInViewController.swift
//  Places
//
//  Created by  Buxlan on 7/20/21.
//

import UIKit

class SignInViewController: UIViewController {
  
    // MARK: - Public
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private
    private lazy var logo: UILabel = {
        let view = UILabel()
        view.text = L10n.App.name
        view.textColor = .darkText
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.font = .bxControlTitle
        return view
    }()
    
    private lazy var dismissButton: UIButton = {
        let view = UIButton()
        view.setImage(Asset.xmark.image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var imageView: UIView = {
        
        let image = Asset.onboarding3.image
        
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowRadius = 50
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 12, height: 12)
        view.layer.shadowColor = UIColor.bxText1.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
                        
        let imageView = UIImageView()
        imageView.image = image
        imageView.backgroundColor = Asset.background0.color
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(imageView)
        
        return view
    }()
            
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = L10n.Auth.title
        view.textColor = .bxText1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = .bxControlTitle
        return view
    }()
    
    private lazy var usernameView: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.placeholder = L10n.Auth.usernamePlaceholder
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Asset.background2.color.cgColor
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
                
        view.leftView = leftView
        view.leftViewMode = .always
        
        return view
    }()
    
    private lazy var passwordView: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.placeholder = L10n.Auth.passwordPlaceholder
        view.isSecureTextEntry = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Asset.background2.color.cgColor
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
        view.leftView = leftView
        view.leftViewMode = .always
        
        let image = Asset.lock.image
        let size = CGSize(width: 16, height: 16)
        let frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        
        let rend = UIGraphicsImageRenderer(size: size, format: image.imageRendererFormat)
        let resizedImage = rend.image { _ in
            image.draw(in: frame)
        }
                
        let imageView = UIImageView(frame: frame)
        imageView.alpha = 0.5
        imageView.setImage(resizedImage)
        imageView.contentMode = .scaleAspectFit
        
        let viewSize = CGSize(width: size.width + 8, height: size.height)
        let viewFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: viewSize)
        let rightView = UIView(frame: viewFrame)
        rightView.addSubview(imageView)
        
        view.rightView = rightView
        view.rightViewMode = .unlessEditing
                
        return view
    }()
    
    private lazy var buttonsStack: UIStackView = {
//        let flexView = UIView()
//        flexView.backgroundColor = .red
//        flexView.setContentHuggingPriority(.defaultLow, for: .vertical)
        let subviews = [signInButton, forgetPasswordButton, signUpButton]
        let view = UIStackView(arrangedSubviews: subviews)
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private lazy var signInButton: ButtonWithShadow = {
        
        let view = ButtonWithShadow(title: L10n.Auth.Buttons.login,
                                          image: nil)
        
        view.backgroundColor = .bxControlBackground
        view.titleLabel?.backgroundColor = view.backgroundColor
        view.imageView?.backgroundColor = view.backgroundColor
        
        view.addTarget(self, action: #selector(signIn), for: .touchUpInside)
  
        return view
    }()
    
    private lazy var signUpButton: ButtonWithShadow = {
        let view = ButtonWithShadow(title: L10n.Auth.Buttons.signUp,
                                      image: nil)
        view.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return view
    }()
    
    private lazy var forgetPasswordButton: OnboardingSkipButton = {
        let view = OnboardingSkipButton(title: L10n.Onboarding.Buttons.later,
                                      image: nil)
        view.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return view
    }()
    
    // MARK: - events and actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Asset.background0.color
        
        view.addSubview(logo)
        view.addSubview(dismissButton)
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(usernameView)
        view.addSubview(passwordView)
        view.addSubview(buttonsStack)
        
        configureConstraints()
 
    }

    private func configureConstraints() {
                
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
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -8),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                              constant: -32),
            usernameView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            usernameView.heightAnchor.constraint(equalToConstant: 44),
            usernameView.widthAnchor.constraint(equalTo: buttonsStack.widthAnchor),
            usernameView.bottomAnchor.constraint(equalTo: passwordView.topAnchor, constant: -8),

            passwordView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            passwordView.heightAnchor.constraint(equalToConstant: 44),
            passwordView.widthAnchor.constraint(equalTo: buttonsStack.widthAnchor),
            passwordView.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -8),
            
            buttonsStack.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                               constant: -8),
            buttonsStack.widthAnchor.constraint(greaterThanOrEqualTo: view.layoutMarginsGuide.widthAnchor,
                                                multiplier: 0.5),
            buttonsStack.widthAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.widthAnchor,
                                                multiplier: 0.8),
            buttonsStack.heightAnchor.constraint(equalToConstant: 148)

        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    func signIn() {
        
    }
    
    @objc
    func signUp() {
        
    }
    
    @objc
    func dismissTapped() {
        dismiss(animated: true) {
            
        }
    }

}

extension SignInViewController: UITextFieldDelegate {
            
}
