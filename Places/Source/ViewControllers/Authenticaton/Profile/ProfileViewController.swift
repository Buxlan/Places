//
//  ProfileViewController.swift
//  Places
//
//  Created by  Buxlan on 5/28/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        // Tab bar configure
        tabBarItem.title = L10n.Profile.title
        let image = Asset.person.image.resizeImage(to: 24,
                                                   aspectRatio: .current,
                                                   with: view.tintColor)
        let selImage = Asset.person.image.resizeImage(to: 26,
                                                      aspectRatio: .current,
                                                      with: view.tintColor)
        tabBarItem.image = image
        tabBarItem.selectedImage = selImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public vars and properties
    
    // MARK: - Public functions
    
    // MARK: - UI Elements
    private struct Strings {
        static let title = "Profile"
    }
    
    // MARK: - Events and actions
    
    // MARK: Other private vars, properties and methods
    private var login: String? {
        didSet {
            // firstViewResponder = Password view
        }
    }
    private var password: String? {
        didSet {
            
        }
    }
    
    // MARK: - UI objects
    private lazy var logo: UILabel = {
        let view = UILabel()
        view.text = L10n.App.name
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.font = .bxControlTitle
        return view
    }()
    
    private lazy var imageView: UIView = {
        
        let image = Asset.onboarding3.image
        
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowRadius = 50
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 12, height: 12)
        view.layer.shadowColor = Asset.other0.color.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
                        
        let imageView = UIImageView()
        imageView.image = image
        imageView.backgroundColor = Asset.other1.color
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(imageView)
        
        return view
    }()
    
    private lazy var userNameTextField: UITextField = {
        
        let view = UITextField()
        view.delegate = self
        view.placeholder = L10n.Auth.usernamePlaceholder
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Asset.other1.color.cgColor
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
                
        view.leftView = leftView
        view.leftViewMode = .always
        
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        
        let view = UITextField()
        view.delegate = self
        view.placeholder = L10n.Auth.passwordPlaceholder
        view.isSecureTextEntry = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Asset.other1.color.cgColor
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
                
        view.leftView = leftView
        view.leftViewMode = .always
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = L10n.Auth.title
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = .bxControlTitle
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let view = UILabel()
        view.text = L10n.Onboarding.onboardngText1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 10
        view.font = .bxBody
        return view
    }()
    
    private lazy var buttonSignIn: ButtonWithShadow = {
        let view = ButtonWithShadow(title: L10n.Auth.Buttons.login,
                                      image: nil)
        view.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return view
    }()
    
    private lazy var buttonForgetPassword: OnboardingSkipButton = {
        let view = OnboardingSkipButton(title: L10n.Onboarding.Buttons.later,
                                      image: nil)
        view.addTarget(self, action: #selector(passwordRecovery), for: .touchUpInside)
        return view
    }()
    
    // MARK: - events and actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Asset.other1.color
        
        view.addSubview(logo)
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(textLabel)
        view.addSubview(userNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(buttonSignIn)
        view.addSubview(buttonForgetPassword)
        
        configureConstraints()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private lazy var staticConstraints: [NSLayoutConstraint] = {
        let constraints: [NSLayoutConstraint] = [
            
            logo.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,
                                               constant: 8),
            logo.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
                       
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
            
            userNameTextField.heightAnchor.constraint(equalTo: buttonSignIn.heightAnchor),
            userNameTextField.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            userNameTextField.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            passwordTextField.heightAnchor.constraint(equalTo: buttonSignIn.heightAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            passwordTextField.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            buttonForgetPassword.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonForgetPassword.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                                 constant: -8),
            buttonForgetPassword.widthAnchor.constraint(equalTo: buttonSignIn.widthAnchor),
            buttonForgetPassword.heightAnchor.constraint(equalTo: buttonSignIn.heightAnchor),
            
            buttonSignIn.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor)
        ]
        return constraints
    }()
    
    private lazy var constraintsWithHiddenKeyboard: [NSLayoutConstraint] = {
        let constraints: [NSLayoutConstraint] = [
            userNameTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor,
                                                      constant: -8),
            passwordTextField.bottomAnchor.constraint(equalTo: buttonSignIn.topAnchor,
                                                      constant: -8),
            buttonSignIn.bottomAnchor.constraint(equalTo: buttonForgetPassword.topAnchor,
                                                 constant: -8)
        ]
        return constraints
    }()
    
    private lazy var constraintsWithShowedKeyboard: [NSLayoutConstraint] = {
        let constraints: [NSLayoutConstraint] = [
            userNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                 constant: 8),
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor,
                                                      constant: 8),
            buttonSignIn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                                 constant: 8)
        ]
        return constraints
    }()
    
    private var keyboardHidden = true
    
    private func configureConstraints() {
        if self.view.constraints.isEmpty {
            let constraints = staticConstraints + constraintsWithHiddenKeyboard
            NSLayoutConstraint.activate(constraints)
        } else {
            if keyboardHidden {
                NSLayoutConstraint.deactivate(constraintsWithShowedKeyboard)
                NSLayoutConstraint.activate(constraintsWithHiddenKeyboard)
            } else {
                NSLayoutConstraint.deactivate(constraintsWithHiddenKeyboard)
                NSLayoutConstraint.activate(constraintsWithShowedKeyboard)
            }
            view.setNeedsLayout()
        }
    }
    
    @objc
    func keyboardShow() {
        keyboardHidden = false
        self.textLabel.alpha = 0
        self.configureConstraints()
    }
    
    @objc
    func keyboardHide() {
        keyboardHidden = true
        let anim = UIViewPropertyAnimator(duration: 1, curve: .linear) {
            self.textLabel.alpha = 1
        }
        anim.startAnimation()
    }
    
    @objc
    func signIn() {
        
    }
    
    @objc
    func passwordRecovery() {
        
    }

}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            resignFirstResponder()
        }
        return true
    }
    
}
