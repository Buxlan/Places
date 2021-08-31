//
//  ProfileViewModel.swift
//  Places
//
//  Created by  Buxlan on 8/1/21.
//

import UIKit

class ProfileViewModel: NSObject {
    
    // MARK: - Properties
    let user: PlaceUser
    var isLogged: Bool {
        user.isLogged
    }
    var sections: [Section] {
        return _sections
    }
    private lazy var _sections: [Section] = {
        var options: [SettingsOptionType]
        options = [
            .staticCell(model: SettingsOption(title: L10n.Profile.edit,
                                              icon: Asset.person.image,
                                              iconBackgroundColor: Asset.accent0.color,
                                              handler: {
                                              })),
            .staticCell(model: SettingsOption(title: L10n.Profile.logout,
                                              icon: Asset.person.image,
                                              iconBackgroundColor: Asset.accent1.color,
                                              handler: {
                                              }))
        ]
        let section1 = Section(title: L10n.Settings.SectionTitles.general, items: options)
                
        options = [
            .switchCell(model: SettingsSwitchOption(title: L10n.Settings.allowNotifications,
                                              icon: Asset.person.image,
                                              iconBackgroundColor: Asset.accent0.color,
                                              handler: { [weak self] in
                                                self?.user.settings.notificationsAllowed.toggle()
                                              },
                                              isOn: user.settings.notificationsAllowed)),
            .switchCell(model: SettingsSwitchOption(title: L10n.Settings.allowEmails,
                                              icon: Asset.person.image,
                                              iconBackgroundColor: Asset.accent1.color,
                                              handler: { [weak self] in
                                                self?.user.settings.emailsAllowed.toggle()
                                              },
                                              isOn: user.settings.emailsAllowed))
        ]
        let section2 = Section(title: L10n.Settings.SectionTitles.communication, items: options)
        return [section1, section2]
    }()
    
    // MARK: - Init
    override init() {
        user = PlaceUser.current
        super.init()
    }
    
    // MARK: - Helper functions
    
    func item(at indexPath: IndexPath) -> SettingsOptionType {
        guard indexPath.section >= 0 && indexPath.section < sections.count else {
            fatalError()
        }
        
        return sections[indexPath.section].items[indexPath.row]
    }
    
}
