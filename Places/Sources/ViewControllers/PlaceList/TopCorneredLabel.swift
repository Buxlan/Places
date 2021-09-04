//
//  TopCorneredLayout.swift
//  Places
//
//  Created by  Buxlan on 7/27/21.
//

import UIKit

class TopCorneredLabel: UILabel {
    
    var cornerRadius: CGFloat
    var corners: UIRectCorner
    
    init(corners: UIRectCorner, radius: CGFloat) {
        self.corners = corners
        self.cornerRadius = radius
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: corners, radius: cornerRadius)
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
    
}

class CorneredImageView: UIImageView {
    
    var cornerRadius: CGFloat
    var corners: UIRectCorner
    
    init(corners: UIRectCorner, radius: CGFloat) {
        self.corners = corners
        self.cornerRadius = radius
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: corners, radius: cornerRadius)
    }
    
}

class CorneredView: UIView {
    
    var cornerRadius: CGFloat
    var corners: UIRectCorner
    
    init(corners: UIRectCorner, radius: CGFloat) {
        self.corners = corners
        self.cornerRadius = radius
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: corners, radius: cornerRadius)
    }    
    
}
