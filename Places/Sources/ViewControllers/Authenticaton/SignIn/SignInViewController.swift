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

// For Sign in with Apple
import AuthenticationServices
import CommonCrypto

class SignInViewController: UIViewController, DataSourceProviderDelegate {
    
    // MARK: - Public
    private let kFacebookAppID = "ENTER APP ID HERE"
    var dataSourceProvider: DataSourceProvider<AuthProvider>?
    
    // MARK: - init, events and handlers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        let authProvidersTableView = UITableView(frame: .zero, style: .grouped)
        authProvidersTableView.allowsMultipleSelection = false
        authProvidersTableView.allowsSelectionDuringEditing = false
        authProvidersTableView.allowsMultipleSelectionDuringEditing = false
        authProvidersTableView.translatesAutoresizingMaskIntoConstraints = false
        authProvidersTableView.isUserInteractionEnabled = true
        authProvidersTableView.allowsSelection = true
        authProvidersTableView.rowHeight = 48
        authProvidersTableView.estimatedRowHeight = 48
        view = authProvidersTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        //        gesture.numberOfTapsRequired = 1
        //        gesture.numberOfTouchesRequired = 1
        //        view.addGestureRecognizer(gesture)
        
        configureDataSourceProvider()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureBars()
    }
    
    private func configureBars(animated: Bool = false) {
        navigationController?.setToolbarHidden(true, animated: animated)
        
        navigationController?.navigationBar.barTintColor = Asset.other1.color
//        navigationController?.navigationBar.tintColor = Asset.other0.color
        configureNavigationBar(animated: animated)
    }
    
    private func configureNavigationBar(animated: Bool = false) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = L10n.SignIn.title
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.prefersLargeTitles = true
        navigationBar.titleTextAttributes = [.foregroundColor: Asset.accent1.color]
        navigationBar.largeTitleTextAttributes = [.foregroundColor: Asset.accent1.color]
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
        case .facebook:
            performFacebookSignInFlow()
        case .emailPassword:
            performDemoEmailPasswordLoginFlow()
        case .anonymous:
            performAnonymousLoginFlow()
        case .registration:
            performRegistrationUserFlow()
        }
    }
    
    // MARK: - Firebase 🔥
    
    private func performGoogleSignInFlow() {
        guard let app = FirebaseApp.app(),
              let clientID = app.options.clientID else {
            return
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { (user, error) in
            guard error == nil else { return self.displayError(error) }
            
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                let isMFAEnabled = true
                if let error = error {
                    let authError = error as NSError
                    if isMFAEnabled, authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                        // The user is a multi-factor user. Second factor challenge is required.
                        guard let resolver = authError
                                .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as? MultiFactorResolver else {
                            return
                        }
                        var displayNameString = ""
                        for tmpFactorInfo in resolver.hints {
                            displayNameString += tmpFactorInfo.displayName ?? ""
                            displayNameString += " "
                        }
                        self.showTextInputPrompt(
                            withMessage: "Select factor to sign in\n\(displayNameString)",
                            completionBlock: { userPressedOK, displayName in
                                var selectedHint: PhoneMultiFactorInfo?
                                for tmpFactorInfo in resolver.hints {
                                    if displayName == tmpFactorInfo.displayName {
                                        selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
                                    }
                                }
                                PhoneAuthProvider.provider()
                                    .verifyPhoneNumber(with: selectedHint!, uiDelegate: nil,
                                                       multiFactorSession: resolver
                                                        .session) { verificationID, error in
                                        if error != nil {
                                            print(
                                                "Multi factor start sign in failed. Error: \(error.debugDescription)"
                                            )
                                        } else {
                                            self.showTextInputPrompt(
                                                withMessage: "Verification code for \(selectedHint?.displayName ?? "")",
                                                completionBlock: { userPressedOK, verificationCode in
                                                    let credential: PhoneAuthCredential? = PhoneAuthProvider.provider()
                                                        .credential(withVerificationID: verificationID!,
                                                                    verificationCode: verificationCode!)
                                                    let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator
                                                        .assertion(with: credential!)
                                                    resolver.resolveSignIn(with: assertion!) { authResult, error in
                                                        if error != nil {
                                                            print(
                                                                "Multi factor finanlize sign in failed. Error: \(error.debugDescription)"
                                                            )
                                                        } else {
                                                            self.navigationController?.popViewController(animated: true)
                                                        }
                                                    }
                                                }
                                            )
                                        }
                                    }
                            }
                        )
                    } else {
                        self.showMessagePrompt(error.localizedDescription)
                        return
                    }
                    // ...
                    return
                }
                // User is signed in
                self.transitionToUserViewController()
            }
        }
    }
    
    // For Sign in with Apple
    var currentNonce: String?
    
    private func performFacebookSignInFlow() {
        
    }
    
    private func performDemoEmailPasswordLoginFlow() {
        let loginController = LoginController()
        loginController.delegate = self
        navigationController?.pushViewController(loginController, animated: true)
    }
    
    private func performAnonymousLoginFlow() {
        Auth.auth().signInAnonymously { result, error in
            guard error == nil else { return self.displayError(error) }
            self.transitionToUserViewController()
        }
    }
    
    private func performRegistrationUserFlow() {
        
    }
    
    private func signin(with credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { result, error in
            guard error == nil else { return self.displayError(error) }
            //            self.transitionToUserViewController()
        }
    }
    
    // MARK: - Private Helpers
    
    private func configureDataSourceProvider() {
        guard let tableView = self.view as? UITableView else { return }
        dataSourceProvider = DataSourceProvider(dataSource: AuthProvider.sections, tableView: tableView)
        dataSourceProvider?.delegate = self
    }
    
    private func transitionToUserViewController() {
        // UserViewController is at index 1 in the tabBarController.viewControllers array
//              tabBarController?.transitionToViewController(atIndex: 1)
    }
    
    func showMessagePrompt(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    
    /*! @fn showTextInputPromptWithMessage
     @brief Shows a prompt with a text field and 'OK'/'Cancel' buttons.
     @param message The message to display.
     @param completion A block to call when the user taps 'OK' or 'Cancel'.
     */
    func showTextInputPrompt(withMessage message: String,
                             completionBlock: @escaping ((Bool, String?) -> Void)) {
        let prompt = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionBlock(false, nil)
        }
        weak var weakPrompt = prompt
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = weakPrompt?.textFields?.first?.text else { return }
            completionBlock(true, text)
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(cancelAction)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
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
