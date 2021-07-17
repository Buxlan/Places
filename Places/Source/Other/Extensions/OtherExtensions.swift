//
//  Extensions.swift
//  Places
//
//  Created by  Buxlan on 5/6/21.
//

import UIKit
import Firebase

extension UIView {
    // Function finds root view controller
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

extension UIImageView {
    func setImage(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.3 : 0.0
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: nil)
    }
}

// extension UITableView {
//    func perform(result: List.Result) {
//        if result.hasChanges {
//            self.beginUpdates()
//            if !(result.deletes.isEmpty) {
//                self.deleteRows(at: result.deletes.compactMap {
//                    IndexPath(row: $0, section: 0)
//                }, with: .automatic)
//            }
//            if !result.inserts.isEmpty {
//                self.insertRows(at: result.inserts.compactMap { IndexPath(row: $0, section: 0) }, with: .automatic)
//            }
//            if !result.updates.isEmpty {
//                self.reloadRows(at: result.updates.compactMap { IndexPath(row: $0, section: 0) }, with: .automatic)
//            }
//            if !result.moves.isEmpty {
//                result.moves.forEach({ (index) in
//                    let toIndexPath = IndexPath(row: index.to, section: 0)
//                    self.moveRow(at: IndexPath(row: index.from, section: 0), to: toIndexPath)
//                })
//            }
//            self.endUpdates()
//        }
//    }
// }

extension UIButton {
    
    static func onboardingButton(title: String, image: UIImage?) -> UIButton {
        
        let button = UIButton()
        
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        
        button.setTitleColor(.bxLightText, for: .normal)
        button.backgroundColor = .bxControlBackground
        
        button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 12
        
        // configure insets
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 40, bottom: 15, right: 40)
        
        return button
    }
    
}

extension Notification.Name {
    
    static let onboardingDismiss = Notification.Name("onboardingDismiss")
    
}

extension String {
    func localized() -> String {
        // To do smth later
        return self
    }
}

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

// MARK: - Extending a `Firebase User` to conform to `DataSourceProvidable`

extension User: DataSourceProvidable {
    private var infoSection: Section {
        let items = [Item(title: providerID, detailTitle: "Provider ID"),
                     Item(title: uid, detailTitle: "UUID"),
                     Item(title: displayName ?? "––", detailTitle: "Display Name", isEditable: true),
                     Item(
                        title: photoURL?.absoluteString ?? "––",
                        detailTitle: "Photo URL",
                        isEditable: true
                     ),
                     Item(title: email ?? "––", detailTitle: "Email", isEditable: true),
                     Item(title: phoneNumber ?? "––", detailTitle: "Phone Number")]
        return Section(headerDescription: "Info", items: items)
    }
    
    private var metaDataSection: Section {
        let metadataRows = [
            Item(title: metadata.lastSignInDate?.description, detailTitle: "Last Sign-in Date"),
            Item(title: metadata.creationDate?.description, detailTitle: "Creation Date")
        ]
        return Section(headerDescription: "Firebase Metadata", items: metadataRows)
    }
    
    private var otherSection: Section {
        let otherRows = [Item(title: isAnonymous ? "Yes" : "No", detailTitle: "Is User Anonymous?"),
                         Item(title: isEmailVerified ? "Yes" : "No", detailTitle: "Is Email Verified?")]
        return Section(headerDescription: "Other", items: otherRows)
    }
    
    private var actionSection: Section {
        let actionsRows = [
            Item(title: UserAction.refreshUserInfo.rawValue, textColor: .systemBlue),
            Item(title: UserAction.signOut.rawValue, textColor: .systemBlue),
            Item(title: UserAction.link.rawValue, textColor: .systemBlue, hasNestedContent: true),
            Item(title: UserAction.requestVerifyEmail.rawValue, textColor: .systemBlue),
            Item(title: UserAction.tokenRefresh.rawValue, textColor: .systemBlue),
            Item(title: UserAction.delete.rawValue, textColor: .systemRed)
        ]
        return Section(headerDescription: "Actions", items: actionsRows)
    }
    
    var sections: [Section] {
        [infoSection, metaDataSection, otherSection, actionSection]
    }
}

// MARK: - UIKit Extensions

extension UIViewController {
    public func displayError(_ error: Error?, from function: StaticString = #function) {
        guard let error = error else { return }
        print("ⓧ Error in \(function): \(error.localizedDescription)")
        let message = "\(error.localizedDescription)\n\n Ocurred in \(function)"
        let errorAlertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        errorAlertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(errorAlertController, animated: true, completion: nil)
    }
}

extension UINavigationController {
//    func configureTabBar(title: String, systemImageName: String) {
//        let tabBarItemImage = UIImage(systemName: systemImageName)
//        tabBarItem = UITabBarItem(title: title,
//                                  image: tabBarItemImage?.withRenderingMode(.alwaysTemplate),
//                                  selectedImage: tabBarItemImage)
//    }
    
    enum TitleType: CaseIterable {
        case regular, large
    }
    
    func setTitleColor(_ color: UIColor, _ types: [TitleType] = TitleType.allCases) {
        if types.contains(.regular) {
            navigationBar.titleTextAttributes = [.foregroundColor: color]
        }
        if types.contains(.large) {
            navigationBar.largeTitleTextAttributes = [.foregroundColor: color]
        }
    }
}

extension UITextField {
    func setImage(_ image: UIImage?) {
        guard let image = image else { return }
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        
        let containerView = UIView()
        containerView.frame = CGRect(x: 20, y: 0, width: 40, height: 40)
        containerView.addSubview(imageView)
        leftView = containerView
        leftViewMode = .always
    }
}

extension UIImageView {
//    convenience init(systemImageName: String, tintColor: UIColor? = nil) {
//        var systemImage = UIImage(systemName: systemImageName)
//        if let tintColor = tintColor {
//            systemImage = systemImage?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
//        }
//        self.init(image: systemImage)
//    }
    
    func setImage(from url: URL?) {
        guard let url = url else { return }
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.image = image
                self.contentMode = .scaleAspectFit
            }
        }
    }
}

// MARK: UINavigationBar + UserDisplayable Protocol

protocol UserDisplayable {
    func addProfilePic(_ imageView: UIImageView)
}

extension UINavigationBar: UserDisplayable {
    func addProfilePic(_ imageView: UIImageView) {
        let length = frame.height * 0.46
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = length / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: length),
            imageView.widthAnchor.constraint(equalToConstant: length)
        ])
    }
}

// MARK: Extending UITabBarController to work with custom transition animator

extension UITabBarController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController,
                                 animationControllerForTransitionFrom fromVC: UIViewController,
                                 to toVC: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
        let fromIndex = tabBarController.viewControllers!.firstIndex(of: fromVC)!
        let toIndex = tabBarController.viewControllers!.firstIndex(of: toVC)!
        
        let direction: Animator.TransitionDirection = fromIndex < toIndex ? .right : .left
        return Animator(direction)
    }
    
    func transitionToViewController(atIndex index: Int) {
        selectedIndex = index
    }
}

// MARK: - Foundation Extensions

extension Date {
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}
