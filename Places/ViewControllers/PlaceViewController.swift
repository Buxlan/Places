//
//  PlaceViewController.swift
//  Places
//
//  Created by  Buxlan on 5/19/21.
//

import UIKit

class PlaceViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    // temp entry
    let place = PlaceController().collections[0].places[0]
    
    var viewModel: PlaceViewModel! = nil
    lazy var tableDirector: PlaceTableViewDirector = {
        return PlaceTableViewDirector(tableView: tableView,
                                      items: viewModel.items,
                                      footerConfigurator: PlaceTableFooterConfigurator(item: place),
                                      headerConfigurator: PlaceTableHeaderConfigurator(item: place))
    }()
    
    lazy var playBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(systemItem: .play, primaryAction: UIAction(handler: { (action) in
            self.playTapped()
        }))
        item.tintColor = .systemGray6
        return item
    }()
    
    override func viewDidLoad() {
        
        viewModel = PlaceViewModel(place: place)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        configureBar()
        
        addHandlers()
    }
    
    private func addHandlers() {
        tableDirector.configureHandlers()
    }
    
    private func configureBar() {
        
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.barTintColor = .systemBlue
        
        let backItem = UIBarButtonItem(title: "<<<", style: .done, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItem = backItem
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.systemGray6
        title = "Place"
        
        let font: UIFont = .preferredFont(forTextStyle: .largeTitle)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let symbol = UIImage(systemName: "play.fill", withConfiguration: configuration)

        let items = [
            UIBarButtonItem(systemItem: .flexibleSpace),
            playBarButtonItem,
            UIBarButtonItem(image: UIImage.bxPreferredSymbol(with: "record.circle"), style: .plain, target: self, action: #selector(recordTapped)),
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
