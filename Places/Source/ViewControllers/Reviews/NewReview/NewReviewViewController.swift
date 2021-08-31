//
//  NewReviewViewController.swift
//  Places
//
//  Created by  Buxlan on 8/3/21.
//

import UIKit

class NewReviewViewController: UIViewController {

    // MARK: - Properties
    private static let cellReuseIdentifier = String.init(describing: NewReviewViewController.self)
    private var viewModel =  EditProfileViewModel()
    private lazy var imageContainer: UIView = {
        let view = UIView()
        //        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 32
        view.layer.masksToBounds = true
        view.addSubview(imageButtonView)
        return view
    }()
    
    private lazy var imageButtonView: UIButton = {
        let view = UIButton()
        view.tintColor = .white
        view.imageView?.contentMode = .scaleAspectFit
        view.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
        
        if let image = viewModel.userImage {
            let size = CGSize(width: 150, height: 150)
            let rect = CGRect(origin: .zero,
                              size: size)
            let format = image.imageRendererFormat
            format.opaque = false
            let rend = UIGraphicsImageRenderer(size: size,
                                               format: image.imageRendererFormat)
            let ellipsedImage = rend.image {_ in
                UIBezierPath(ovalIn: rect).addClip()
                image.draw(in: rect)
            }
            view.setImage(ellipsedImage, for: .normal)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = PlaceUser.current.name
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = PlaceUser.current.email
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userInfoTableView: UITableView = {
        let view = UITableView()
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = false
        view.delegate = self
        view.dataSource = self
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = 80
        view.estimatedRowHeight = 80
        view.register(UITableViewCell.self,
                      forCellReuseIdentifier: NewReviewViewController.cellReuseIdentifier)
        
        let frame = CGRect(x: 0, y: 0, width: 0, height: 170)
        imageContainer.frame = frame
        view.tableHeaderView = imageContainer
        view.tableFooterView = UIView()
        return view
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
        
        //        view.addSubview(imageContainer)
        view.addSubview(userInfoTableView)
        
        //        imageContainer.addSubview(imageView)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            //            imageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //            imageContainer.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
            //            imageContainer.widthAnchor.constraint(equalToConstant: 200),
            //            imageContainer.heightAnchor.constraint(equalToConstant: 200),
            //
            imageButtonView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            imageButtonView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            imageButtonView.widthAnchor.constraint(equalToConstant: 150),
            imageButtonView.heightAnchor.constraint(equalToConstant: 150),
            
            userInfoTableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            userInfoTableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            userInfoTableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            userInfoTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    private func imageTapped() {
        let anim = UIViewPropertyAnimator(duration: 0.5,
                                          curve: .easeInOut) { [weak self] in
            self?.imageButtonView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }
        anim.addCompletion { [weak self] _ in
            self?.imageButtonView.transform = .identity
            let vc = PhotoViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        anim.startAnimation()
    }
}

extension NewReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewReviewViewController.cellReuseIdentifier,
                                                 for: indexPath)
        let userInfo = viewModel.items[indexPath.row]
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        switch userInfo {
        case .displayName(let value, let icon):
            cell.textLabel?.text = value
            cell.imageView?.setImage(icon)
        case .contacts(let value, let icon):
            cell.textLabel?.text = value
            cell.imageView?.setImage(icon)
        case .email(let value, let icon):
            cell.textLabel?.text = value
            cell.imageView?.setImage(icon)
        }
        cell.accessoryType = .detailButton
        return cell
    }
}
