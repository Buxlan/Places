//
//  ProfileViewController.swift
//  Places
//
//  Created by  Buxlan on 5/28/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    lazy var viewModel: ProfileViewModel = ProfileViewModel()
    
    private lazy var tableView: UITableView  = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.delegate = self
        view.dataSource = self
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.rowHeight = UITableView.automaticDimension
//        view.estimatedRowHeight = UITableView.automaticDimension
        view.rowHeight = 60
        view.estimatedRowHeight = 60
        view.register(SettingCell.self,
                      forCellReuseIdentifier: SettingCell.reuseIdentifier)
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        let userInfoHeader = UserInfoHeader(frame: frame)
        view.tableHeaderView = userInfoHeader
        view.tableFooterView = UIView()
        return view
    }()
       
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        configureTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        view.addSubview(tableView)
        view.backgroundColor = Asset.other2.color
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureBars(animated: false)
    }
    
    // MARK: - Helper functions
    
    private func configureTabBarItem() {
        tabBarItem.title = L10n.Profile.title
        let image = Asset.person.image.resizeImage(to: 24,
                                                   aspectRatio: .current,
                                                   with: view.tintColor)
        let selImage = Asset.person.image.resizeImage(to: 26,
                                                      aspectRatio: .current,
                                                      with: view.tintColor)
        tabBarItem.image = image
        tabBarItem.selectedImage = selImage
    }
    
    private func configureBars(animated: Bool = false) {
        navigationController?.setToolbarHidden(true, animated: animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.barTintColor = Asset.other1.color
        navigationController?.navigationBar.tintColor = Asset.other0.color
        navigationController?.tabBarController?.tabBar.isHidden = false
    }

    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// Delegate
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sec = viewModel.sections[section]
        return sec.title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0,
           indexPath.row == 0 {
            let vc = EditProfileViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
   
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
                
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier,
                                                 for: indexPath)
        
        if let cell = cell as? SettingCell {
            cell.configure(option: item)
        }
        return cell
    }
        
}
