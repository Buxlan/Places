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
    
    override func viewDidLoad() {
        
        viewModel = PlaceViewModel(place: place)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        configureToolbar()
        
        addHandlers()
    }
    
    private func addHandlers() {
        tableDirector.configureHandlers()
    }
    
    private func configureToolbar() {
        
        navigationController?.isToolbarHidden = false
        
        let font: UIFont = .preferredFont(forTextStyle: .largeTitle)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let symbol = UIImage(systemName: "play.fill", withConfiguration: configuration)
        
        let items = [
            UIBarButtonItem(systemItem: .flexibleSpace),
            UIBarButtonItem(systemItem: .play, primaryAction: UIAction(handler: { (action) in
                self.playTapped()
            })),
            UIBarButtonItem(systemItem: .flexibleSpace),
            UIBarButtonItem(systemItem: .flexibleSpace),
            UIBarButtonItem(systemItem: .flexibleSpace),
            UIBarButtonItem(image: UIImage.bxPreferredSymbol(with: "record.circle"), style: .plain, target: self, action: #selector(recordTapped)),
            UIBarButtonItem(systemItem: .flexibleSpace)
        ]
        setToolbarItems(items, animated: true)
        navigationController?.toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        
    }
    
    @objc
    func playTapped() {
        print("Play sound")
    }
    
    @objc
    func recordTapped() {
        print("Record")
    }
    
}
