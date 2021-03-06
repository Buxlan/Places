//
//  Garbage.swift
//  Places
//
//  Created by  Buxlan on 5/7/21.
//

import Foundation
import UIKit

class Garbage {
    
    @objc func action() {
        fatalError("That's tapped which cannot tapped")
    }
    
    lazy var firstButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("My first button", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        button.addTarget(self, action: #selector(action), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.setImage(Asset.arrowRight.image, for: UIControl.State.normal)
        return button
        
        // in viewDidLoad
        //        frame = CGRect(...)
        //        let blurEffect = UIBlurEffect(style: .light)
        //        let blurView = UIVisualEffectView.init(effect: blurEffect)
        //        blurView.frame = frame
        //
        //        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect, style: .label)
        //        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        //        vibrancyView.frame = firstButton.bounds
        //
        //        vibrancyView.contentView.addSubview(firstButton)
        //        blurView.contentView.addSubview(vibrancyView)
        //        view.addSubview(blurView)
        
    }()  
    
}

open class PaddedTextField: UITextField {
    public var textInsets = UIEdgeInsets.zero {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
