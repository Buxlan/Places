//
//  EditProfileViewModel.swift
//  Places
//
//  Created by  Buxlan on 8/1/21.
//

import UIKit

struct EditProfileViewModel {
    
    var userImage: UIImage? {
        PlaceUser.current.image
    }
    
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
        .displayName(value: PlaceUser.current.displayName,
                     icon: Asset.person.image.resizeImage(to: 20,
                                                          aspectRatio: .current,
                                                          with: Asset.accent0.color)),
        .contacts(value: PlaceUser.current.contacts,
                  icon: Asset.person.image.resizeImage(to: 20,
                                                       aspectRatio: .current,
                                                       with: Asset.accent0.color)),
        .email(value: PlaceUser.current.email,
               icon: Asset.person.image.resizeImage(to: 20,
                                                    aspectRatio: .current,
                                                    with: Asset.accent0.color))
    ]
}
