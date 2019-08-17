//
//  StoryboardInstantiated.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

protocol StoryboardInstantiated {
    static func instantiate(_ storyboardName: String) -> Self
}

extension StoryboardInstantiated where Self: UIViewController {
    
    static func instantiate(_ storyboardName: String) -> Self {
        let name = String(describing: Self.self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: name) as! Self
    }
    
}
