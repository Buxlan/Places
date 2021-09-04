//
//  UserInfoHeader.swift
//  Places
//
//  Created by  Buxlan on 8/1/21.
//

import UIKit

class UserInfoHeader: UIView {
    
    // MARK: - Properties    
    var user: PlaceUser = PlaceUser.current
    
    lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var usernameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emailLabel: UILabel = {
        let view = UILabel()
        view.text = PlaceUser.current.email
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(emailLabel)
        
        let profileImageDimension: CGFloat = 60
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.layer.cornerRadius = profileImageDimension / 2
        
        usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        emailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        
        configureUI()
    }
    
    convenience init(user: PlaceUser) {
        self.init(frame: .zero)
        self.user = user
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    func configureUI() {
        usernameLabel.text = user.displayName
        emailLabel.text = user.email
        
        let emptyImage = Asset.person.image
        profileImageView.image = emptyImage
        if let url = user.photoURL {
            let session = URLSession.shared
            let task = session.downloadTask(with: url, completionHandler: { fileURL, response, error in
                if let error = error {
                    print("error download: \(error.localizedDescription)")
                }
                if let url = fileURL,
                   let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.profileImageView.image = image
                    }
                }
            })
            task.resume()
        }
    }
    
}
