// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit
import Firebase

// For Account Linking with Sign in with Google.
import GoogleSignIn

// For Account Linking with Sign in with Apple.
import AuthenticationServices
import CryptoKit

class AccountLinkingViewController: UIViewController, DataSourceProviderDelegate {
    var dataSourceProvider: DataSourceProvider<AuthProvider>!
    
    var tableView: UITableView {
        guard let tableView = view as? UITableView else {
            return UITableView(frame: .zero, style: .grouped)
        }
        return tableView
    }
    
    override func loadView() {
        view = UITableView(frame: .zero, style: .grouped)
    }
    
    let user: User
    
    /// Designated initializer requires a valid, non-nil Firebase user.
    /// - Parameter user: An instance of a Firebase `User`.
    init(for user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureDataSourceProvider()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setTitleColor(.systemOrange)
    }
    
    // MARK: - DataSourceProviderDelegate
    
    func didSelectRowAt(_ indexPath: IndexPath, on tableView: UITableView) {
        let item = dataSourceProvider.item(at: indexPath)
        
        let providerName = item.title!
        
        guard let provider = AuthProvider(rawValue: providerName) else {
            // The row tapped has no affiliated action.
            return
        }
        
        // If the item's affiliated provider is currently linked with the user,
        // unlink the provider from the user's account.
        if item.isChecked {
            unlinkFromProvider(provider.id)
            return
        }
        
        switch provider {
        case .google:
            performGoogleAccountLink()
            
        case .facebook:
            performFacebookAccountLink()
            
        case .emailPassword:
            performEmailPasswordAccountLink()
            
        default:
            break
        }
    }
    
    // MARK: Firebase 🔥
    
    /// Wrapper method that uses Firebase's `link(with:)` API to link a user to another auth provider.
    /// Used when linking a user to each of the following auth providers.
    /// This method will update the UI upon the linking's completion.
    /// - Parameter authCredential: The credential used to link the user with the auth provider.
    private func linkAccount(authCredential: AuthCredential) {
        user.link(with: authCredential) { result, error in
            guard error == nil else { return self.displayError(error) }
            self.updateUI()
        }
    }
    
    /// Wrapper method that uses Firebase's `unlink(fromProvider:)` API to unlink a user from an auth provider.
    /// This method will update the UI upon the unlinking's completion.
    /// - Parameter providerID: The string id of the auth provider.
    private func unlinkFromProvider(_ providerID: String) {
        user.unlink(fromProvider: providerID) { user, error in
            guard error == nil else { return self.displayError(error) }
            print("Unlinked user from auth provider: \(providerID)")
            self.updateUI()
        }
    }
    
    // MARK: - Sign in with Google Account Linking 🔥
    
    /// This method will initate the Google Sign In flow.
    /// See this class's conformance to `GIDSignInDelegate` below for
    /// context on how the linking is made.
    private func performGoogleAccountLink() {
        
        guard let app = FirebaseApp.app(),
              let clientID = app.options.clientID else {
            return
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { (user, error) in
            guard error == nil else { return self.displayError(error) }
            
            guard let authentication = user?.authentication else { return }
            guard let idToken = authentication.idToken else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else { return self.displayError(error) }
                
                // At this point, our user is signed in
                // so we advance to the User View Controller
                self.transitionToUserViewController()
            }
        }
    }
    
    // MARK: - Sign in with Apple Account Linking 🔥
    
    // For Sign in with Apple
    var currentNonce: String?
    
    // MARK: - Sign in with Facebook Account Linking 🔥
    
    private func performFacebookAccountLink() {
        
    }
    
    // MARK: - Email & Password Login Account Linking 🔥
    
    private func performEmailPasswordAccountLink() {
        presentEmailPasswordLinkAlertController { [weak self] email, password in
            guard let strongSelf = self else { return }
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            strongSelf.linkAccount(authCredential: credential)
        }
    }
    // MARK: - UI Configuration
    
    private func configureNavigationBar() {
        navigationItem.title = "Account Linking"
        navigationItem.backBarButtonItem?.tintColor = .systemYellow
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func presentTextFieldAlertController(title: String? = nil,
                                                 message: String? = nil,
                                                 textfieldPlaceholder: String? = nil,
                                                 saveHandler: @escaping (String) -> Void) {
        let textFieldAlertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        textFieldAlertController.addTextField { textfield in
            textfield.placeholder = textfieldPlaceholder
            textfield.textContentType = .oneTimeCode
        }
        
        let onContinue: (UIAlertAction) -> Void = { _ in
            let text = textFieldAlertController.textFields!.first!.text!
            saveHandler(text)
        }
        
        textFieldAlertController.addAction(
            UIAlertAction(title: "Continue", style: .default, handler: onContinue)
        )
        
        textFieldAlertController.addAction(
            UIAlertAction(title: "Cancel", style: .cancel)
        )
        
        present(textFieldAlertController, animated: true, completion: nil)
    }
    
    private func presentEmailPasswordLinkAlertController(linkHandler: @escaping (String, String)
                                                            -> Void) {
        let loginAlertController = UIAlertController(
            title: "Link Password Auth",
            message: "Enter a valid email and password to link",
            preferredStyle: .alert
        )
        
        ["Email", "Password"].forEach { placeholder in
            loginAlertController.addTextField { textfield in
                textfield.placeholder = placeholder
            }
        }
        
        let onContinue: (UIAlertAction) -> Void = { _ in
            let email = loginAlertController.textFields![0].text!
            let password = loginAlertController.textFields![1].text!
            linkHandler(email, password)
        }
        
        loginAlertController
            .addAction(UIAlertAction(title: "Continue", style: .default, handler: onContinue))
        loginAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(loginAlertController, animated: true, completion: nil)
    }
    
    // MARK: - TableView Configuration & Refresh
    
    private func configureDataSourceProvider() {
        dataSourceProvider = DataSourceProvider(
            dataSource: sections,
            tableView: tableView
        )
        dataSourceProvider.delegate = self
    }
    
    private func updateUI() {
        configureDataSourceProvider()
        animateUpdates(for: tableView)
    }
    
    private func animateUpdates(for tableView: UITableView) {
        UIView.transition(with: tableView, duration: 0.05,
                          options: .transitionCrossDissolve,
                          animations: { tableView.reloadData() })
    }
    
    private func transitionToUserViewController() {
      // UserViewController is at index 1 in the tabBarController.viewControllers array
    }
    
}

// MARK: DataSourceProvidable

extension AccountLinkingViewController: DataSourceProvidable {
    var sections: [AuthSection] { buildSections() }
    
    private func buildSections() -> [AuthSection] {
        var section = AuthProvider.authLinkSections.first!
        section.items = section.items.compactMap { (item) -> AuthItem? in
            var item = item
            item.hasNestedContent = false
            item.isChecked = userProviderDataContains(item: item)
            return ["Anonymous Authentication", "Custom Auth System"].contains(item.title) ? nil : item
        }
        return [section]
    }
    
    private func userProviderDataContains(item: AuthItem) -> Bool {
        guard let authProvider = AuthProvider(rawValue: item.title ?? "") else { return false }
        return user.providerData.map({$0.providerID}).contains(authProvider.id)
    }
}
