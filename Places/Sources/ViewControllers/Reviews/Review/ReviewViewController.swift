//
//  ReviewViewController.swift
//  Places
//
//  Created by  Buxlan on 7/28/21.
//

import UIKit

class ReviewViewController: UIViewController {
    
    // MARK: - Public
    private var viewModel: ReviewViewModel
    var review: Review = Review.empty {
        didSet {
            viewModel.review = review
        }
    }
    struct Strings {
        static let backBarButtonTitle = "<<<"
        static let playImageName = "play.fill"
        static let recordImageName = "record.circle"
    }
    
    @IBOutlet private var tableView: UITableView!
    private lazy var swipeGesture: UIScreenEdgePanGestureRecognizer = {
        let gest = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(swiped))
        gest.edges = .left
        gest.delegate = self
        return gest
    }()
    
    private lazy var playBarButtonItem: UIBarButtonItem = {
        let image = Asset.play.image
        let item = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(playTapped))
        return item
    }()
    
//    init(review: Review) {
//        self.review = review
//        viewModel = ReviewViewModel(review: review, tableView: tableView)
//        super.init(nibName: nil, bundle: nil)
//    }
    
    required init?(coder: NSCoder) {
        viewModel = ReviewViewModel()
        super.init(coder: coder)
        title = L10n.App.name
    }
    
    override func viewDidLoad() {
        
        viewModel.tableView = tableView
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
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
        configureBars()
    }
    
    // MARK: - Private
        
    private func addHandlers() {
        viewModel.configureHandlers()
    }
    
    private func configureBars() {
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
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

extension ReviewViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
