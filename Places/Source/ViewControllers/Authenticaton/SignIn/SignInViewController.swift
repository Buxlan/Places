//
//  SignInViewController.swift
//  Places
//
//  Created by  Buxlan on 7/20/21.
//

import UIKit
import Firebase

// For Sign in with Google
import GoogleSignIn

// For Sign in with Facebook
import FBSDKLoginKit

// For Sign in with Apple
import AuthenticationServices
import CommonCrypto

class SignInViewController: UIViewController, DataSourceProviderDelegate {
    
    // MARK: - Public
    private let kFacebookAppID = "ENTER APP ID HERE"
    var dataSourceProvider: DataSourceProvider<AuthProvider>?
    
    private lazy var logoImageView: UIView = {
        
        let image = Asset.onboarding3.image
        
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowRadius = 25
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 12, height: 12)
        view.layer.shadowColor = Asset.other0.color.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.backgroundColor = Asset.other1.color
        imageView.layer.cornerRadius = 25
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
        view.addTarget(self, action: #selector(signInHandle), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var forgotPasswordButton: ButtonWithShadow = {
        let view = ButtonWithShadow(title: L10n.Auth.forgotPassword,
                                    image: nil)
        view.backgroundColor = Asset.other1.color
        view.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var googleSignInButton: UIButton = {
        let view = UIButton()
        let image = Asset.google.image.resizeImage(to: 30, aspectRatio: .current, with: .clear)
        let title = L10n.Auth.Buttons.googleSignIn
        view.backgroundColor = .black
        view.setTitleColor(.white, for: .normal)
        view.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 8)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.setImage(image, for: .normal)
        view.setTitle(title, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        view.addTarget(self, action: #selector(appleSignInHandle), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var appleSignInButton: UIButton = {
        let view = UIButton()
        let image = Asset.apple.image.resizeImage(to: 44, aspectRatio: .current, with: .clear)
        let title = L10n.Auth.Buttons.appleSignIn
        view.backgroundColor = .black
        view.setTitleColor(.white, for: .normal)
        view.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 8)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.setImage(image, for: .normal)
        view.setTitle(title, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        view.addTarget(self, action: #selector(appleSignInHandle), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var facebookSignInButton: UIButton = {
        let view = UIButton()
        let image = Asset.facebook.image.resizeImage(to: 30, aspectRatio: .current, with: .clear)
        let title = L10n.Auth.Buttons.facebookSignIn
        let textColor = Asset.facebookLogin.color
        view.backgroundColor = .white
        view.setTitleColor(textColor, for: .normal)
        view.contentEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 8)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.setImage(image, for: .normal)
        view.setTitle(title, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        view.addTarget(self, action: #selector(appleSignInHandle), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = textColor.cgColor
        return view
    }()
    
    private lazy var authProvidersTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = UITableView.automaticDimension
//        view.register(SettingCell.self,
//                      forCellReuseIdentifier: SettingCell.reuseIdentifier)
//
//        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
//        let userInfoHeader = UserInfoHeader(frame: frame)
//        view.tableHeaderView = userInfoHeader
//        view.tableFooterView = UIView()
        return view
    }()
    
    // MARK: - init, events and handlers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Asset.other1.color
        
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(googleSignInButton)
        view.addSubview(facebookSignInButton)
        view.addSubview(appleSignInButton)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(gesture)
        
        configureConstraints()
        configureDataSourceProvider()
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
            
            logoImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            logoImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 16),
            logoImageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.25),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,
                                            constant: 8),
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
            
            googleSignInButton.topAnchor.constraint(greaterThanOrEqualTo: forgotPasswordButton.bottomAnchor, constant: 16),
            googleSignInButton.widthAnchor.constraint(equalTo: signInButton.widthAnchor),
            googleSignInButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            googleSignInButton.heightAnchor.constraint(equalToConstant: 44),
            
            facebookSignInButton.topAnchor.constraint(equalTo: googleSignInButton.bottomAnchor, constant: 8),
            facebookSignInButton.widthAnchor.constraint(equalTo: signInButton.widthAnchor),
            facebookSignInButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            facebookSignInButton.heightAnchor.constraint(equalTo: googleSignInButton.heightAnchor),
            
            appleSignInButton.topAnchor.constraint(equalTo: facebookSignInButton.bottomAnchor, constant: 8),
            appleSignInButton.widthAnchor.constraint(equalTo: signInButton.widthAnchor),
            appleSignInButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            googleSignInButton.heightAnchor.constraint(equalTo: googleSignInButton.heightAnchor),            
            appleSignInButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                                      constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    func signInHandle() {
        
    }
    
    @objc
    func signUpHandle() {
        
    }
    
    @objc
    func googleSignInHandle() {
        
    }
    
    @objc
    func appleSignInHandle() {
        
    }
    
    @objc
    func facebookSignInHandle() {
        
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
    
    // MARK: - DataSourceProviderDelegate
    
    func didSelectRowAt(_ indexPath: IndexPath, on tableView: UITableView) {
        guard let dataSourceProvider = dataSourceProvider else {
            // noting happen
            return
        }
        let item = dataSourceProvider.item(at: indexPath)
        
        let providerName = item.isEditable ? item.detailTitle! : item.title!
        
        guard let provider = AuthProvider(rawValue: providerName) else {
            // The row tapped has no affiliated action.
            return
        }
        
        switch provider {
        case .google:
            performGoogleSignInFlow()
        case .apple:
            performAppleSignInFlow()
        case .facebook:
            performFacebookSignInFlow()
        case .emailPassword:
            performDemoEmailPasswordLoginFlow()
        case .anonymous:
            performAnonymousLoginFlow()
        }
    }
    
    // MARK: - Firebase 🔥
    
    private func performGoogleSignInFlow() {
        // Configure the Google Sign In instance
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()!.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    // For Sign in with Apple
    var currentNonce: String?
    
    private func performAppleSignInFlow() {
//        let nonce = randomNonceString()
//        currentNonce = nonce
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let request = appleIDProvider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//        request.nonce = sha256(nonce)
//
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
    }
    
    private func performFacebookSignInFlow() {
        // The following config can also be stored in the project's .plist
        Settings.appID = kFacebookAppID
        Settings.displayName = "AuthenticationExample"
        
        // Create a Facebook `LoginManager` instance
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["email"], from: self) { result, error in
            guard error == nil else { return self.displayError(error) }
            guard let accessToken = AccessToken.current else { return }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            self.signin(with: credential)
        }
    }
    
    private func performDemoEmailPasswordLoginFlow() {
        let loginController = LoginController()
        loginController.delegate = self
        navigationController?.pushViewController(loginController, animated: true)
    }
    
    private func performAnonymousLoginFlow() {
        Auth.auth().signInAnonymously { result, error in
            guard error == nil else { return self.displayError(error) }
//            self.transitionToUserViewController()
        }
    }
    
    private func signin(with credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { result, error in
            guard error == nil else { return self.displayError(error) }
//            self.transitionToUserViewController()
        }
    }
    
    // MARK: - Private Helpers

    private func configureDataSourceProvider() {
      let tableView = view as? UITableView
      dataSourceProvider = DataSourceProvider(dataSource: AuthProvider.sections, tableView: tableView)
      dataSourceProvider?.delegate = self
    }

    private func transitionToUserViewController() {
      // UserViewController is at index 1 in the tabBarController.viewControllers array
//      tabBarController?.transitionToViewController(atIndex: 1)
    }
}

// MARK: - GIDSignInDelegate for Google Sign In

extension SignInViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else { return displayError(error) }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { result, error in
            guard error == nil else { return self.displayError(error) }
            
            // At this point, our user is signed in
            // so we advance to the User View Controller
            //      self.transitionToUserViewController()
        }
    }
}

// MARK: - LoginDelegate

extension SignInViewController: LoginDelegate {
    public func loginDidOccur() {
        //    transitionToUserViewController()
    }
}

// MARK: - Implementing Sign in with Apple with Firebase

extension SignInViewController {
    // MARK: ASAuthorizationControllerDelegate
    
//    func authorizationController(controller: ASAuthorizationController,
//                                 didCompleteWithAuthorization authorization: ASAuthorization) {
//        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
//        else {
//            print("Unable to retrieve AppleIDCredential")
//            return
//        }
//
//        guard let nonce = currentNonce else {
//            fatalError("Invalid state: A login callback was received, but no login request was sent.")
//        }
//        guard let appleIDToken = appleIDCredential.identityToken else {
//            print("Unable to fetch identity token")
//            return
//        }
//        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
//            return
//        }
//
//        let credential = OAuthProvider.credential(withProviderID: "apple.com",
//                                                  idToken: idTokenString,
//                                                  rawNonce: nonce)
//
//        Auth.auth().signIn(with: credential) { result, error in
//            // Error. If error.code == .MissingOrInvalidNonce, make sure
//            // you're sending the SHA256-hashed nonce as a hex string with
//            // your request to Apple.
//            guard error == nil else { return self.displayError(error) }
//
//            // At this point, our user is signed in
//            // so we advance to the User View Controller
//            //      self.transitionToUserViewController()
//        }
//    }
//
//      func authorizationController(controller: ASAuthorizationController,
//                                   didCompleteWithError error: Error) {
//        // Ensure that you have:
//        //  - enabled `Sign in with Apple` on the Firebase console
//        //  - added the `Sign in with Apple` capability for this project
//        print("Sign in with Apple errored: \(error)")
//      }
        
    // MARK: Aditional `Sign in with Apple` Helpers
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let data = Data(input.utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            data.withUnsafeBytes {
                _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
            }
        let hashedData = Data(hash)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
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
            signInHandle()
        }
        return true
    }
    
}
