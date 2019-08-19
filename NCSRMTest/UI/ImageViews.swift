//
//  ImageViews.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-18.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

@IBDesignable
class ImageView: UIImageView {
    
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
    
    override init(image: UIImage?) {
        super.init(image: image)
        configure()
    }
    
    func configure() {
        // Override
    }
    
}

class RoundedImageView: ImageView {
    override func configure() {
        super.configure()
        
        layer.cornerRadius = 8.0
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowRadius = 4.0
    }
}

class TintedImageView: ImageView {
    override func configure() {
        super.configure()
        
        tintColor = .textColor
    }
}
