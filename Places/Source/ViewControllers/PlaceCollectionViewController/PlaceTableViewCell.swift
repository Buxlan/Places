//
//  PlaceTableViewCell.swift
//  Places
//
//  Created by  Buxlan on 6/16/21.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
           
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        isUserInteractionEnabled = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init with code fatal error")
//        Log(text: "init with coder", object: nil)
    }
    
}

struct PlaceCellConfiguration: UIContentConfiguration {
    
    var place: Place?
    
    func makeContentView() -> UIView & UIContentView {
        let view = PlaceContentView(self)
        return view
    }
    
    func updated(for state: UIConfigurationState) -> PlaceCellConfiguration {
        return self
    }
}

class PlaceContentView: UIView, UIContentView {
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        self.addSubview(imageView)
        self.addSubview(stackView)
        self.addSubview(titleView)
        self.addSubview(descriptionView)
               
        let constraints: [NSLayoutConstraint] = [
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleView.widthAnchor.constraint(equalTo: self.widthAnchor),
            titleView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            
            descriptionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            descriptionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            descriptionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8),
            descriptionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
//            likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
//            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
//            likeButton.heightAnchor.constraint(equalTo: likeButton.widthAnchor),
//            likeButton.widthAnchor.constraint(equalToConstant: 30),
            
        ]
        likeButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        NSLayoutConstraint.activate(constraints)
        
        configure(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        
        var view = UIStackView(arrangedSubviews: [likeButton, shareButton])
        view.backgroundColor = .placeholderText
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.semanticContentAttribute = .forceRightToLeft
        view.distribution = .equalSpacing
        view.alignment = .trailing
        
        return view
        
    }()
    
    private lazy var titleView: UILabel = {
        let titleView = UILabel(frame: .zero)
        titleView.font = UIFont.bxBody
        titleView.textColor = .bxOrdinaryLabel
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        return titleView
    }()
    
    private lazy var descriptionView: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.bxCaption
        view.textColor = .bxSecondaryLabel
        view.numberOfLines = 5        
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let action = UIAction { (action) in
            Log(text: "123", object: nil)
            self.likeButton.isSelected.toggle()
        }
        let view = UIButton(primaryAction: action)
        let image = UIImage.bxPreferredSymbol(with: "suit.heart.fill")
        let selectedImage = UIImage.bxPreferredSymbol(with: "suit.heart")
        view.tintColor = .systemPink
        
        view.setImage(image, for: .normal)
        view.setImage(selectedImage, for: .selected)
//        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var shareButton: UIButton = {
        let action = UIAction { (action) in
            Log(text: "123", object: nil)
            self.likeButton.isSelected.toggle()
        }
        let view = UIButton(primaryAction: action)
        let image = UIImage.bxPreferredSymbol(with: "arrowshape.turn.up.right.fill")
        let selectedImage = UIImage.bxPreferredSymbol(with: "arrowshape.turn.up.right")
        view.tintColor = .systemPink
        
        view.setImage(image, for: .normal)
        view.setImage(selectedImage, for: .selected)
//        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    internal var configuration: UIContentConfiguration {
        didSet {
            self.configure(configuration: configuration)
        }
    }
    
    private func configure(configuration: UIContentConfiguration) {
        guard let conf = configuration as? PlaceCellConfiguration else {
            fatalError()
        }
        imageView.image = conf.place?.image
        titleView.text = conf.place?.title
        descriptionView.text = conf.place?.description
    }
    
    
}

