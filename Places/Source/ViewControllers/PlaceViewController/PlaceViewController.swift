//
//  PlaceViewController.swift
//  Places
//
//  Created by  Buxlan on 5/19/21.
//

import UIKit

class PlaceViewController: UIViewController {
    
    // MARK: - Public
    var place: Place!
        
    // MARK: - Private
    struct Strings {
        static let backBarButtonTitle = "<<<"
        static let playImageName = "play.fill"
        static let recordImageName = "record.circle"
    }
    
    @IBOutlet private var tableView: UITableView!
    
    private var viewModel: PlaceViewModel! = nil
    private lazy var tableDirector: PlaceTableViewDirector = {
        return PlaceTableViewDirector(tableView: tableView,
                                      items: viewModel.items,
                                      footerConfigurator: PlaceTableFooterConfigurator(item: place),
                                      headerConfigurator: PlaceTableHeaderConfigurator(item: place))
    }()
    
    private lazy var playBarButtonItem: UIBarButtonItem = {
        let image = UIImage.playIcon
        let item = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(playTapped))
        item.tintColor = .bxLightText
        return item
    }()
    
    // MARK: - Events and actions
    override func viewDidLoad() {
        
        title = "Place"
        
        viewModel = PlaceViewModel(place: place)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        configureBar()
        
        addHandlers()
        
        super.viewDidLoad()
    }
    
    private func addHandlers() {
        tableDirector.configureHandlers()
    }
    
    private func configureBar() {
        
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.barTintColor = .bxBackground
        
        let backItem = UIBarButtonItem(title: Strings.backBarButtonTitle, style: .done, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItem = backItem
        
        navigationItem.leftBarButtonItem?.tintColor = .bxLightText
        title = "Place"
                
        let items = [
//            UIBarButtonItem(systemItem: .flexibleSpace),
            playBarButtonItem,
            UIBarButtonItem(image: .micIcon,
                            style: .plain,
                            target: self,
                            action: #selector(recordTapped))
        ]
        setToolbarItems(items, animated: true)
        
//        navigationController?.toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
//        navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        
    }
    
    @objc
    func playTapped() {
        print("Play sound")
    }
    
    @objc
    func recordTapped() {
        print("Record")
    }
    
    @objc
    func backTapped(sender: Any?) {
        navigationController?.popViewController(animated: true)
    }
    
}
