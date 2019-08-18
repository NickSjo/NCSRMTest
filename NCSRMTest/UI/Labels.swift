//
//  Labels.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-18.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

@IBDesignable
class Label: UILabel {
    
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


class Title1Label: Label {
    override func configure() {
        super.configure()
        
        font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        textColor = .textColor
    }
}

class Title2Label: Label {
    override func configure() {
        super.configure()
        
        font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        textColor = .textColor
    }
}

class BodyLabel: Label {
    override func configure() {
        super.configure()
        
        font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        textColor = .textColor
    }
}

class Caption1Label: Label {
    override func configure() {
        super.configure()
        
        font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        textColor = .textColor
    }
}
