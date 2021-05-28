//
//  Config.swift
//  xTimers
//
//  Created by  Buxlan on 29.03.2021.
//

import UIKit

struct Config {
    
    let type: AppSettings.Appearance
        
    struct General {
        static let appName = "Places"
//        static let appGroupName = "group.com.buxlan.xTimers"
//        static let iCloudContainerName = "iCloud.com.buxlan.xTimers"
        static let contactEmail = "buxlan51@gmail.com"
//        static let languages = [LanguageModel(name: "LANGUAGE_OPTION_1".localized(), code: "en_US")]
        
//        static var dateFormatter: DateFormatter { 
//            let formatter = DateFormatter()
//            formatter.dateFormat = "d MMM, HH:mm"
//            return formatter
//        }
//        
//        static var timeFormatter: DateFormatter { 
//            let formatter = DateFormatter()
//            formatter.dateFormat = "HH:mm"
//            return formatter
//        }
        
//        static let themes = [ThemeModel(name: "Alizarin Red", backgroundColor: Colors.red, appIcon: nil),
//                             ThemeModel(name: "Vanadyl Blue", backgroundColor: Colors.blue, appIcon: "IconBlue"),
//                             ThemeModel(name: "Skirret Green", backgroundColor: Colors.green, appIcon: "IconGreen"),
//                             ThemeModel(name: "Sunflower Yellow", backgroundColor: Colors.yellow, appIcon: "IconYellow"),
//                             ThemeModel(name: "Radiant Orange", backgroundColor: Colors.orange, appIcon: "IconOrange"),
//                             ThemeModel(name: "Rose Pink", backgroundColor: Colors.pink, appIcon: "IconPinkAlt"),
//                             ThemeModel(name: "Midnight Black", backgroundColor: Colors.black, appIcon: "IconBlack")]
        
//        static let startPageTitles = ["CONFIG_OPTIONS_PREF1".localized(),
//                                      "CONFIG_OPTIONS_PREF2".localized(),
//                                      "CONFIG_OPTIONS_PREF3".localized(),
//                                      "CONFIG_OPTIONS_PREF4".localized(),
//                                      "CONFIG_OPTIONS_PREF5".localized(),
//                                      "CONFIG_OPTIONS_PREF6".localized(),
//                                      "CONFIG_OPTIONS_PREF7".localized()]
//
//        static let sortTitles = ["CONFIG_SORT_PREF1".localized(),
//                                 "CONFIG_SORT_PREF2".localized(),
//                                 "CONFIG_SORT_PREF3".localized(),
//                                 "CONFIG_SORT_PREF4".localized()]
        
//        static let priorityColors = [Config.Colors.red,
//                                     Config.Colors.orange,
//                                     Config.Colors.yellow,
//                                     Config.Colors.green]
        
//        static let priorityTitles = ["CONFIG_PRIORITY_PREF1".localized(),
//                                     "CONFIG_PRIORITY_PREF2".localized(),
//                                     "CONFIG_PRIORITY_PREF3".localized(),
//                                     "CONFIG_PRIORITY_PREF4".localized(),
//                                     "CONFIG_PRIORITY_PREF5".localized()]
        
    }
    
    class Colors: NSObject {
        
        static let bxWeekend: UIColor = UIColor(named: "weekend")!
        static let bxLightGray: UIColor = UIColor(named: "lightGray")!
        static let bxGray: UIColor = UIColor(named: "gray")!
        static let bxDarkBackground: UIColor = UIColor(named: "bgDark")!
        static let bxLightBackground: UIColor = UIColor(named: "bgLight")!
        
        static let calendarDot: UIColor = UIColor.systemBlue
        static let calendarSelectedDay: UIColor = UIColor.systemBlue
        static let calendarCurrentDay: UIColor = UIColor.systemOrange
    }
    
    class Options: NSObject {
        static let theme = "theme"
        static let language = "language"
        static let startPage = "startPage"
        static let launchedBefore = "launchedBefore"
        static let helpPrompts = "helpPrompts"
        static let userFullName = "userFullName"
        static let openLinks = "openLinksOption"
        static let disableAutoReminders = "disableAutoReminders"
    }
    
    class NotificationOptions: NSObject {
        static let themeUpdated = NSNotification.Name("themeUpdated")
        static let threeDTouchShortcut = NSNotification.Name("3DTouchShortcut")
        static let shouldReloadData = NSNotification.Name("shouldReloadData")
        static let cloudKitNewData = Notification.Name("cloudKitNewData")
    }
}
