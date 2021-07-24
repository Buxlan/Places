//
//  PlaceViewController.swift
//  Places
//
//  Created by  Buxlan on 5/19/21.
//

import UIKit

class PlaceViewController: UIViewController {
    
    // MARK: - Public
    var place: Place
    struct Strings {
        static let backBarButtonTitle = "<<<"
        static let playImageName = "play.fill"
        static let recordImageName = "record.circle"
    }
    
    init(place: Place) {
        self.place = place
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        place = Place.empty
        super.init(coder: coder)
        title = L10n.App.name
    }
    
    override func viewDidLoad() {
        
        viewModel = PlaceViewModel(place: place)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = true
        
        configureBars()
        
        addHandlers()
        view.addGestureRecognizer(swipeGesture)
//        tableView.addGestureRecognizer(swipeGesture)
//        tableView.panGestureRecognizer.require(toFail: swipeGesture)
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.removeGestureRecognizer(swipeGesture)
    }
    
    // MARK: - Private
    @IBOutlet private var tableView: UITableView!
    private lazy var swipeGesture: UIScreenEdgePanGestureRecognizer = {
        let gest = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(swiped))
        gest.edges = .left
        gest.delegate = self
        return gest
    }()
    
    private var viewModel: PlaceViewModel! = nil
    private lazy var tableDirector: PlaceTableViewDirector = {
        return PlaceTableViewDirector(tableView: tableView,
                                      items: viewModel.items,
                                      footerConfigurator: PlaceTableFooterConfigurator(item: place),
                                      headerConfigurator: PlaceTableHeaderConfigurator(item: place))
    }()
    
    private lazy var playBarButtonItem: UIBarButtonItem = {
        let image = Asset.play.image
        let item = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(playTapped))
        return item
    }()
    
    private func addHandlers() {
        tableDirector.configureHandlers()
    }
    
    private func configureBars() {
        
        navigationController?.isToolbarHidden = false
        tabBarItem.isEnabled = false
                
        let items = [
//            UIBarButtonItem(systemItem: .flexibleSpace),
            playBarButtonItem,
            UIBarButtonItem(image: Asset.mic.image,
                            style: .plain,
                            target: self,
                            action: #selector(recordTapped))
        ]
        setToolbarItems(items, animated: true)
    }
    
    @objc
    private func swiped(_ gesture: UISwipeGestureRecognizer) {
        print("swiped")
    }    
    
    @objc
    private func playTapped() {
        print("Play sound")
    }
    
    @objc
    private func recordTapped() {
        print("Record")
    }
    
    @objc
    private func backTapped(sender: Any?) {
        navigationController?.popViewController(animated: true)
    }
}

extension PlaceViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
