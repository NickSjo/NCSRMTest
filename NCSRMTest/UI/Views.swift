//
//  Views.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-18.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

@IBDesignable
class View: UIView {
    
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

class BackgroundView: View {
    override func configure() {
        super.configure()
        
        backgroundColor = .backgroundColor
    }
}

class CellSeparatorView: View {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 1.0)
    }
    
    override func configure() {
        super.configure()
        
        backgroundColor = .separatorColor
    }
}
