//
//  EditProfileViewModel.swift
//  Places
//
//  Created by  Buxlan on 8/1/21.
//

import UIKit

struct EditProfileViewModel {
    
    let userImage: UIImage? = UIImage(named: User.current.image)
    
    enum UserInfo: CustomStringConvertible {
        case displayName(value: String, icon: UIImage?)
        case contacts(value: String, icon: UIImage?)
        case email(value: String, icon: UIImage?)
        
        var description: String {
            switch self {
            case .displayName(let value, _):
                return value
            case .contacts(let value, _):
                return value
            case .email(let value, _):
                return value
            }
        }
    }
    
    let items: [UserInfo] = [
        .displayName(value: User.current.displayName,
                     icon: Asset.person.image.resizeImage(to: 20,
                                                          aspectRatio: .current,
                                                          with: Asset.accent0.color)),
        .contacts(value: User.current.contacts,
                  icon: Asset.person.image.resizeImage(to: 20,
                                                       aspectRatio: .current,
                                                       with: Asset.accent0.color)),
        .email(value: User.current.email,
               icon: Asset.person.image.resizeImage(to: 20,
                                                    aspectRatio: .current,
                                                    with: Asset.accent0.color))
    ]
}
