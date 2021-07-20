//
//  OnboardingThirdViewController.swift
//  Places
//
//  Created by  Buxlan on 5/27/21.
//

import UIKit

class OnboardingThirdViewController: UIViewController {
    
    // MARK: - public properties and methods
    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UI objects
    private weak var coordinator: OnboardingCoordinator?
    
    private lazy var logo: UILabel = {
        let view = UILabel()
        view.text = L10n.Onboarding.logo
        view.textColor = Asset.darkText.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.font = .bxControlTitle
        return view
    }()
    
    private lazy var dismissButton: UIButton = {
        let view = UIButton()
        view.setImage(Asset.xmark.image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(coordinator, action: #selector(OnboardingCoordinator.dismiss), for: .touchUpInside)
        return view
    }()
    
    private lazy var imageView: UIView = {
        
        let image = Asset.onboarding3.image
        
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowRadius = 50
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 12, height: 12)
        view.layer.shadowColor = Asset.darkText.color.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
                        
        let imageView = UIImageView()
        imageView.image = image
        imageView.backgroundColor = Asset.background.color
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(imageView)
        
        return view
    }()
            
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = L10n.Onboarding.welcomeLogin
        view.textColor = Asset.darkText.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.font = .bxControlTitle
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let view = UILabel()
        view.text = L10n.Onboarding.loginDescription
        view.textColor = Asset.darkText.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 10
        view.font = .bxBody
        return view
    }()
    
    private lazy var buttonsStack: UIStackView = {
//        let flexView = UIView()
//        flexView.backgroundColor = .red
//        flexView.setContentHuggingPriority(.defaultLow, for: .vertical)
        let subviews = [buttonSignIn, buttonSignUp, buttonSkip]
        let view = UIStackView(arrangedSubviews: subviews)
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private lazy var buttonSignIn: ButtonWithShadow = {
                
//        let image = Asset.lock.image
//        let height: CGFloat = 24.0
//        let imageSize = image.size
//        let mult = imageSize.width / imageSize.height
//        let fraction = imageSize.height / height
//        let width = imageSize.width / fraction
//        let newSize = CGSize(width: width, height: height)
        
        let view = ButtonWithShadow(title: L10n.Onboarding.Buttons.login,
                                          image: nil)
                        
//        let size = CGSize(width: width, height: height)
//        let rect = CGRect(x: 0,
//                          y: 0,
//                          width: size.width,
//                          height: size.height)
//        let rend = UIGraphicsImageRenderer(size: size,
//                                           format: image.imageRendererFormat)
//        let im = rend.image { _ in
//            image.draw(in: rect)
//        }
//        let tintedImage = im.maskWithColor(color: .red)
//        view.setImage(tintedImage, for: .normal)
//        view.imageView?.contentMode = .scaleAspectFit
        
        view.backgroundColor = Asset.shadow.color
        view.titleLabel?.backgroundColor = view.backgroundColor
        view.imageView?.backgroundColor = view.backgroundColor
        
        view.addTarget(coordinator, action: #selector(OnboardingCoordinator.signIn), for: .touchUpInside)
  
        return view
    }()
    
    private lazy var buttonSignUp: ButtonWithShadow = {
        let view = ButtonWithShadow(title: L10n.Onboarding.Buttons.signUp,
                                      image: nil)
        view.addTarget(coordinator, action: #selector(OnboardingCoordinator.futher), for: .touchUpInside)
        return view
    }()
    
    private lazy var buttonSkip: OnboardingSkipButton = {
        let view = OnboardingSkipButton(title: L10n.Onboarding.Buttons.later,
                                      image: nil)
        view.addTarget(coordinator, action: #selector(OnboardingCoordinator.dismiss), for: .touchUpInside)
        return view
    }()
    
    // MARK: - events and actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Asset.background.color
        view.tintColor = Asset.appTintColor.color
        
        view.addSubview(logo)
        view.addSubview(dismissButton)
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(textLabel)
        view.addSubview(buttonsStack)
//        view.addSubview(buttonSignIn)
//        view.addSubview(buttonSkip)
        
        configureConstraints()
 
    }

    private func configureConstraints() {
                
        let constraints: [NSLayoutConstraint] = [
            
            logo.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,
                                               constant: 8),
            logo.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
                        
            dismissButton.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            dismissButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 18),
            dismissButton.heightAnchor.constraint(equalTo: dismissButton.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                             constant: -32),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                              constant: -32),

            textLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            textLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,
                                             constant: -32),
            
            buttonsStack.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                               constant: -8),
            buttonsStack.widthAnchor.constraint(greaterThanOrEqualTo: view.layoutMarginsGuide.widthAnchor,
                                                multiplier: 0.5),
            buttonsStack.heightAnchor.constraint(equalToConstant: 148)

        ]
        NSLayoutConstraint.activate(constraints)
    }

}
