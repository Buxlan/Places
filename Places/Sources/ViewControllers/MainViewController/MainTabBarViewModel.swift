//
//  MainTabBarViewModel.swift
//  Places
//
//  Created by  Buxlan on 9/4/21.
//
import UIKit

class MainTabBarViewModel {
    lazy var viewControllers: [UIViewController] = {
        var items = [UIViewController]()
        var vc: UINavigationController
        vc = UINavigationController(rootViewController: LastNewsTableViewController())
        items.append(vc)
        
        vc = UINavigationController(rootViewController: PlaceListViewController())
        items.append(vc)
        
        vc = UINavigationController(rootViewController: AuthorListViewController())
        items.append(vc)
        
        vc = UINavigationController(rootViewController: FavoritePlacesViewController())
        items.append(vc)
        
        vc = UINavigationController(rootViewController: ProfileViewController())
        items.append(vc)
        return items
    }()
}
