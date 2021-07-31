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
            
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = L10n.SignIn.title
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = .bxControlTitle
        return view
    }()
    
    private lazy var usernameTextField: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.placeholder = L10n.Auth.usernamePlaceholder
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Asset.other0.color.cgColor
        view.layer.cornerRadius = 4
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
        view.layer.borderColor = Asset.other0.color.cgColor
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
        view.leftView = leftView
        view.leftViewMode = .always
        
        let color = Asset.other0.color
        let image = Asset.eye.image
        let selectedImage = Asset.fillEye.image
                        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 16)
        button.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        button.setImage(image, for: .normal)
        button.setImage(selectedImage, for: .selected)
        button.addTarget(self, action: #selector(showPasswordTapped), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        
        view.rightView = button
        view.rightViewMode = .always
                
        return view
    }()
        
    private lazy var signInButton: ButtonWithShadow = {
        
        let view = ButtonWithShadow(title: L10n.Auth.Buttons.login,
                                          image: nil)
        view.backgroundColor = Asset.other1.color
        view.addTarget(self, action: #selector(signIn), for: .touchUpInside)
  
        return view
    }()
    
    private lazy var forgotPasswordButton: ButtonWithShadow = {
        let view = ButtonWithShadow(title: L10n.Auth.forgotPassword,
                                      image: nil)
        view.backgroundColor = Asset.other1.color
        view.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        return view
    }()
    
    // MARK: - events and actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Asset.other1.color
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(forgotPasswordButton)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(gesture)
        
        configureConstraints()
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureBars()
    }

    private func configureBars(animated: Bool = false) {
        navigationController?.setToolbarHidden(true, animated: animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.barTintColor = Asset.other1.color
        navigationController?.navigationBar.tintColor = Asset.other0.color
    }

    private func configureConstraints() {
                
        let constraints: [NSLayoutConstraint] = [
            
            imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                            constant: 16),
            titleLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                              constant: -32),
            usernameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            usernameTextField.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            usernameTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -8),
            usernameTextField.heightAnchor.constraint(equalToConstant: 44),

            passwordTextField.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -8),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            signInButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            signInButton.widthAnchor.constraint(greaterThanOrEqualTo: view.layoutMarginsGuide.widthAnchor,
                                                multiplier: 0.6),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 8),
            forgotPasswordButton.widthAnchor.constraint(equalTo: signInButton.widthAnchor),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalTo: signInButton.heightAnchor),
            forgotPasswordButton.bottomAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.bottomAnchor,
                                               constant: -8)
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
    private func showPasswordTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc
    private func forgotPasswordTapped(_ sender: UIButton) {
        
    }
    
    @objc
    private func viewTapped() {
        if view.isFirstResponder {
            view.resignFirstResponder()
            return
        }
        for subview in view.subviews where subview.isFirstResponder {
            subview.resignFirstResponder()
            return
        }
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == usernameTextField {
//            passwordTextField.becomeFirstResponder()
//        } else {
//            textField.resignFirstResponder()
//        }
//        textField.resignFirstResponder()
        configureBars(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            signIn()
        }
        return true
    }
    
}
