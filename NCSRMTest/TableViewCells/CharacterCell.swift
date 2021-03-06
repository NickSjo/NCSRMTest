//
//  CharacterCell.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .backgroundColor
        
        let v = UIView()
        v.backgroundColor = .cellSelectionBackgroundColor
        selectedBackgroundView = v
    }
}
