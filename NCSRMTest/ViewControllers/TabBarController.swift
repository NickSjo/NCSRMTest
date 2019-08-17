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
        let viewController1 = ListTableViewController.instantiate("Main")
        viewController1.viewModel = CharactersListViewModel()
        let navController1 = UINavigationController(rootViewController: viewController1)
        navController1.tabBarItem = UITabBarItem(title: "Characters", image: nil, tag: 0)
        
        let viewController2 = ListTableViewController.instantiate("Main")
        viewController2.viewModel = CharactersListViewModel()
        let navController2 = UINavigationController(rootViewController: viewController2)
        navController2.tabBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 1)
        
        viewControllers = [navController1, navController2]
    }
    
}
