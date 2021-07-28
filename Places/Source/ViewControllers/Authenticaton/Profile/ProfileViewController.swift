//
//  ProfileViewController.swift
//  Places
//
//  Created by  Buxlan on 5/28/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Public
    
    // MARK: Private
    
    // MARK: - UI objects
    private lazy var logoLabel: UILabel = {
        let view = UILabel()
        view.text = L10n.App.name
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.font = .bxControlTitle
        return view
    }()
    
    private lazy var imageView: UIView = {
        
        let image = Asset.onboarding3.image
        
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowRadius = 50
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 12, height: 12)
        view.layer.shadowColor = Asset.other0.color.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
                        
        let imageView = UIImageView()
        imageView.image = image
        imageView.backgroundColor = Asset.other1.color
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(imageView)
        
        return view
    }()
       
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = L10n.Profile.title
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = .bxControlTitle
        return view
    }()
        
    private lazy var buttonSignIn: ButtonWithShadow = {
        let view = ButtonWithShadow(title: L10n.Profile.Buttons.signIn,
                                      image: nil)
        view.backgroundColor = Asset.other1.color
        view.accessibilityIdentifier = "buttonSignIn"
        view.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return view
    }()
    
    private lazy var buttonSignUp: ButtonWithShadow = {
        let view = ButtonWithShadow(title: L10n.Profile.Buttons.signUp,
                                      image: nil)
        view.backgroundColor = Asset.other1.color
        view.accessibilityIdentifier = "buttonSignUp"
        view.tintColor = Asset.other2.color
        view.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return view
    }()
       
    // MARK: - Methods
    init() {
        super.init(nibName: nil, bundle: nil)
        // Tab bar configure
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Asset.other1.color
        
        view.addSubview(logoLabel)
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(buttonSignIn)
        view.addSubview(buttonSignUp)
        
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureBars(animated: false)
    }
    
    private func configureBars(animated: Bool = false) {
        navigationController?.setToolbarHidden(true, animated: animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.barTintColor = Asset.other1.color
        navigationController?.navigationBar.tintColor = Asset.other0.color
    }

    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            logoLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -16),
            logoLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            imageView.centerXAnchor.constraint(equalTo: buttonSignIn.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: buttonSignIn.topAnchor, constant: -16),
            
            buttonSignIn.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 0.6),
            buttonSignIn.centerXAnchor.constraint(equalTo: buttonSignUp.centerXAnchor),
            buttonSignIn.bottomAnchor.constraint(equalTo: buttonSignUp.topAnchor, constant: -16),
            
            buttonSignUp.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            buttonSignUp.widthAnchor.constraint(equalTo: buttonSignIn.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)

    }
    
    @objc
    func signIn() {
        let vc = SignInViewController()
        vc.modalTransitionStyle = .flipHorizontal
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func signUp() {
        let vc = UIViewController.instantiateViewController(withIdentifier: .signUp)
        if let vc = vc as? SignUpViewController {
            vc.modalTransitionStyle = .flipHorizontal
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
