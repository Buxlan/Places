//
//  TemplateViewController.swift
//  Places
//
//  Created by  Buxlan on 8/2/21.
//

import UIKit

@available(iOS 15, *)
class TemplateReviewViewController: UIViewController {
    
    // MARK: - Properties
    private static let cellReuseIdentifier = String.init(describing: TemplateReviewViewController.self)
    private lazy var viewModel: TemplateViewModel = {
        TemplateViewModel()
    }()
        
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureBars()
    }
    
    // MARK: - Helper functions
    private func configureBars() {
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = Asset.other1.color
        navigationController?.navigationBar.tintColor = Asset.other0.color
        navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    private func configureInterface() {
        view.backgroundColor = Asset.other2.color
        configureConstraints()
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    private func buttonAction() {
        
    }
}

@available(iOS 15, *)
extension TemplateReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TemplateReviewViewController.cellReuseIdentifier,
                                                 for: indexPath)
        
        return cell
    }
}
