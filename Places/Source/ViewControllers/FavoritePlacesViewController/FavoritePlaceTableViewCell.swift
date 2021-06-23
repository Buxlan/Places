//
//  FavoritePlaceTableViewCell.swift
//  Places
//
//  Created by  Buxlan on 6/14/21.
//

import UIKit

class FavoritePlaceTableViewCell: UITableViewCell {
           
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

struct FavoritePlaceCellConfiguration: UIContentConfiguration {
    
    var place: Place?
    
    func makeContentView() -> UIView & UIContentView {
        let view = FavoritePlaceContentView(self)
        return view
    }
    
    func updated(for state: UIConfigurationState) -> FavoritePlaceCellConfiguration {
        return self
    }
}

class FavoritePlaceContentView: UIView, UIContentView {
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        self.addSubview(imageView)
        self.addSubview(titleView)
        self.addSubview(descriptionView)
        self.addSubview(likeButton)
                       
        let constraints: [NSLayoutConstraint] = [
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: self.heightAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            titleView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleView.topAnchor.constraint(equalTo: imageView.topAnchor),
            
            likeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            likeButton.heightAnchor.constraint(equalTo: likeButton.widthAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            
            descriptionView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            descriptionView.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -8),
            descriptionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8),
            descriptionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
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
    
    private lazy var titleView: UILabel = {
        let titleView = UILabel(frame: .zero)
        titleView.font = UIFont.bxBody
        titleView.textColor = .bxDarkText
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        return titleView
    }()
    
    private lazy var descriptionView: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.bxCaption
        view.textColor = .bxSecondaryText
        view.numberOfLines = 0
        
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
        
        view.setImage(image, for: .normal)
        view.setImage(selectedImage, for: .selected)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    internal var configuration: UIContentConfiguration {
        didSet {
            self.configure(configuration: configuration)
        }
    }
    
    private func configure(configuration: UIContentConfiguration) {
        guard let conf = configuration as? FavoritePlaceCellConfiguration else {
            fatalError()
        }
        imageView.image = conf.place?.image
        titleView.text = conf.place?.title
        descriptionView.text = conf.place?.description
    }
        
}
