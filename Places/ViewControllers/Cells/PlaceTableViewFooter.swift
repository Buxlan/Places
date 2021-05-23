//
//  PlaceTableViewFooter.swift
//  Places
//
//  Created by  Buxlan on 5/21/21.
//

import UIKit

class PlaceTableViewFooter: UIView {
    
    static let placePlaySoundAction = "placePlaySoundAction"
    static let reuseIdentifier: String = "PlaceTableViewFooter"
    
    init() {
        
        super.init(frame: .zero)
        
        isUserInteractionEnabled = true
        
        self.backgroundColor = .systemBlue
        
        let font = UIFont.preferredFont(forTextStyle: .headline)
        let textColor = UIColor.systemGray6
        let buttonPlay = UIButton(frame: .zero)
        buttonPlay.addTarget(self, action: #selector(playSoundTapped), for: .touchUpInside)
        
        // configure button's image
        let config = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: "play.fill", withConfiguration: config)
        buttonPlay.setImage(image, for: .normal)
        buttonPlay.imageView?.tintColor = textColor
        
        // configure button's title
        buttonPlay.setTitle("Play sound", for: .normal)
        buttonPlay.titleLabel?.font = font
        buttonPlay.titleLabel?.textColor = textColor
        buttonPlay.setTitleColor(textColor, for: .normal)
        
        // configure button insets
        buttonPlay.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        buttonPlay.titleEdgeInsets.left = 10
        buttonPlay.titleEdgeInsets.right = -10
        buttonPlay.contentEdgeInsets.right += 10
        
        self.addSubview(buttonPlay)
        
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            buttonPlay.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonPlay.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonPlay.widthAnchor.constraint(equalTo: self.widthAnchor),
            buttonPlay.heightAnchor.constraint(equalTo: self.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func playSoundTapped(sender: UIButton) {
        let eventData = CellActionEventData(action: CellAction.custom(Self.placePlaySoundAction), cell: self)
        NotificationCenter.default.post(name: CellAction.notificationName, object: nil, userInfo: ["data": eventData])
    }
    
}

extension PlaceTableViewFooter: ConfigurableView {
    
    func configure(data: Place) {
        
    }
    
}
