//
//  PlaceTableViewFooter.swift
//  Places
//
//  Created by  Buxlan on 5/21/21.
//

import UIKit

class PlaceTableViewFooter: UITableViewHeaderFooterView {
    
    static let placePlaySoundAction = "placePlaySoundAction"
    static let reuseIdentifier: String = "PlaceTableViewFooter"
    
    override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        isUserInteractionEnabled = true
        
        self.backgroundColor = .clear
        
        let font = UIFont.bxControlTitle
        let textColor = UIColor.systemBlue
        let buttonPlay = UIButton(frame: .zero)
        buttonPlay.addTarget(self, action: #selector(playSoundTapped), for: .touchUpInside)
        
        // configure button's image
        let symbol = Asset.play.image
        buttonPlay.setImage(symbol, for: .normal)
        
        // configure button's title
        buttonPlay.titleLabel?.font = font
        buttonPlay.titleLabel?.textColor = textColor
        buttonPlay.setTitleColor(textColor, for: .normal)
        
        // configure button insets
        buttonPlay.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        buttonPlay.titleEdgeInsets.left = 10
        buttonPlay.titleEdgeInsets.right = -10
        buttonPlay.contentEdgeInsets.right += 10
        
        self.contentView.addSubview(buttonPlay)
        
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            buttonPlay.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonPlay.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonPlay.widthAnchor.constraint(equalTo: self.widthAnchor),
            buttonPlay.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) hasn't been implemented")
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
