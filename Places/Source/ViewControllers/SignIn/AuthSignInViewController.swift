//
//  AuthSignInViewController.swift
//  Places
//
//  Created by  Buxlan on 5/28/21.
//

//
//  Copyright (c) 2016 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
import UIKit

import Firebase

@objc(AuthSignInViewController)
class AuthSignInViewController: UIViewController {
    
    // MARK: - Public vars and properties
    
    // MARK: - UI Elements
    
    lazy var emailField: UITextField = {
        let view = UITextField()
        view.font = .bxControlTitle
        view.backgroundColor = .bxSecondaryBackground
        view.textColor = .bxOrdinaryLabel
        return view
    }()
    
    lazy var passwordField: UITextField! = {
        let view = UITextField()
        view.font = .bxControlTitle
        view.backgroundColor = .bxSecondaryBackground
        view.textColor = .bxOrdinaryLabel
        view.isSecureTextEntry = true
        view.passwordRules = UITextInputPasswordRules(descriptor: "required: upper; required: lower; max-consecutive: 3; minlength: 6;")
        return view
    }()
    
    
    lazy var loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("Login", for: .normal)
        view.addTarget(self, action: #selector(didTapEmailLogin), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = .bxControlTitle
        view.backgroundColor = .bxSelectedControlBackground
        view.setTitleColor(.bxSelectedControlLabel, for: .normal)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private struct Strings {
        static let title = "Login via Email"
    }
    
    // MARK: - Events and actions
    
    override func viewDidLoad() {
        
        title = Strings.title
        
        view.backgroundColor = .bxOrdinaryBackground
        Utils.log("Did load", object: self)
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
                
        emailField.placeholder = "Email address"
        passwordField.placeholder = "Password"
                        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        
        let constraints: [NSLayoutConstraint] = [
            emailField.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            emailField.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            emailField.widthAnchor.constraint(equalToConstant: 250),
            
            passwordField.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 8),
            passwordField.widthAnchor.constraint(equalToConstant: 250),
            
            loginButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            loginButton.widthAnchor.constraint(equalToConstant: 150)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
        super.viewDidLoad()
        
    }
    
    // MARK: Other private vars, properties and methods
    private var login: String? {
        didSet {
            passwordField.becomeFirstResponder()
        }
    }
    private var password: String? {
        didSet {
            if emailField.text?.isEmpty ?? true {
                emailField.becomeFirstResponder()
            }
            // Login
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc
    func didTapEmailLogin(_ sender: AnyObject) {
        guard let email = self.emailField.text, let password = self.passwordField.text else {
            self.showMessagePrompt("email/password can't be empty")
            return
        }
        showSpinner {
            // [START headless_email_auth]
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                // [START_EXCLUDE]
                strongSelf.hideSpinner {
                    if let error = error {
                        let authError = error as NSError
                        if (authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
                            // The user is a multi-factor user. Second factor challenge is required.
                            let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                            var displayNameString = ""
                            for tmpFactorInfo in (resolver.hints) {
                                displayNameString += tmpFactorInfo.displayName ?? ""
                                displayNameString += " "
                            }
                            self!.showTextInputPrompt(withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock: { userPressedOK, displayName in
                                var selectedHint: PhoneMultiFactorInfo?
                                for tmpFactorInfo in resolver.hints {
                                    if (displayName == tmpFactorInfo.displayName) {
                                        selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
                                    }
                                }
                                PhoneAuthProvider.provider().verifyPhoneNumber(with: selectedHint!, uiDelegate: nil, multiFactorSession: resolver.session) { verificationID, error in
                                    if error != nil {
                                        print("Multi factor start sign in failed. Error: \(error.debugDescription)")
                                    } else {
                                        self!.showTextInputPrompt(withMessage: "Verification code for \(selectedHint?.displayName ?? "")", completionBlock: { userPressedOK, verificationCode in
                                            let credential: PhoneAuthCredential? = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode!)
                                            let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator.assertion(with: credential!)
                                            resolver.resolveSignIn(with: assertion!) { authResult, error in
                                                if error != nil {
                                                    print("Multi factor finanlize sign in failed. Error: \(error.debugDescription)")
                                                } else {
                                                    strongSelf.navigationController?.popViewController(animated: true)
                                                }
                                            }
                                        })
                                    }
                                }
                            })
                        } else {
                            strongSelf.showMessagePrompt(error.localizedDescription)
                            return
                        }
                    }
                    strongSelf.navigationController?.popViewController(animated: true)
                }
                // [END_EXCLUDE]
            }
            // [END headless_email_auth]
        }
    }
    
    /** @fn requestPasswordReset
     @brief Requests a "password reset" email be sent.
     */
    @IBAction func didRequestPasswordReset(_ sender: AnyObject) {
        showTextInputPrompt(withMessage: "Email:") { [weak self] userPressedOK, email in
            guard let strongSelf = self, let email = email else {
                return
            }
            strongSelf.showSpinner {
                // [START password_reset]
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    // [START_EXCLUDE]
                    strongSelf.hideSpinner {
                        if let error = error {
                            strongSelf.showMessagePrompt(error.localizedDescription)
                            return
                        }
                        strongSelf.showMessagePrompt("Sent")
                    }
                    // [END_EXCLUDE]
                }
                // [END password_reset]
            }
        }
    }
    
    /** @fn getProvidersForEmail
     @brief Prompts the user for an email address, calls @c FIRAuth.getProvidersForEmail:callback:
     and displays the result.
     */
    @IBAction func didGetProvidersForEmail(_ sender: AnyObject) {
        showTextInputPrompt(withMessage: "Email:") { [weak self] userPressedOK, email in
            guard let strongSelf = self else { return }
            guard let email = email else {
                strongSelf.showMessagePrompt("email can't be empty")
                return
            }
            strongSelf.showSpinner {
                // [START get_methods]
                Auth.auth().fetchSignInMethods(forEmail: email) { methods, error in
                    // [START_EXCLUDE]
                    strongSelf.hideSpinner {
                        if let error = error {
                            strongSelf.showMessagePrompt(error.localizedDescription)
                            return
                        }
                        strongSelf.showMessagePrompt(methods!.joined(separator: ", "))
                    }
                    // [END_EXCLUDE]
                }
                // [END get_methods]
            }
        }
    }
    
    @IBAction func didCreateAccount(_ sender: AnyObject) {
        showTextInputPrompt(withMessage: "Email:") {  [weak self] userPressedOK, email in
            guard let strongSelf = self else { return }
            guard let email = email else {
                strongSelf.showMessagePrompt("email can't be empty")
                return
            }
            strongSelf.showTextInputPrompt(withMessage: "Password:") { userPressedOK, password in
                guard let password = password else {
                    strongSelf.showMessagePrompt("password can't be empty")
                    return
                }
                strongSelf.showSpinner {
                    // [START create_user]
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        // [START_EXCLUDE]
                        strongSelf.hideSpinner {
                            guard let user = authResult?.user, error == nil else {
                                strongSelf.showMessagePrompt(error!.localizedDescription)
                                return
                            }
                            print("\(user.email!) created")
                            strongSelf.navigationController?.popViewController(animated: true)
                        }
                        // [END_EXCLUDE]
                    }
                    // [END create_user]
                }
            }
        }
    }
    
}
