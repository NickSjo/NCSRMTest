//
//  Buttons.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-18.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

@IBDesignable
class Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure()
    }
    
    func configure() {
        // Override
    }
    
}

class DefaultButton: Button {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 180, height: 44.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2.0
    }
    
    override func configure() {
        super.configure()
        
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        setTitleColor(.buttonTextColor, for: .normal)
        setTitleColor(UIColor.buttonTextColor.withAlphaComponent(0.5), for: .disabled)
        backgroundColor = .buttonBackgroundColor
    }
    
}

class HighlightButton: Button {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .cellSelectionBackgroundColor : .clear
        }
    }
    
}
