//
//  TabBarController.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
    }

}

private extension TabBarController {
    
    func setupViewControllers() {
        let vc1 = UINavigationController(rootViewController: ListTableViewController.instantiate("Main"))
        vc1.tabBarItem = UITabBarItem(title: "Characters", image: nil, tag: 0)
        let vc2 = UINavigationController(rootViewController: ListTableViewController.instantiate("Main"))
        vc2.tabBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 1)
        
        viewControllers = [vc1, vc2]
    }
    
}
