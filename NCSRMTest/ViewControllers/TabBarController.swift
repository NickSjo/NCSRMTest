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
        navController1.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(named: "icons8-user-male-30"), tag: 0)
        
        let viewController2 = ListTableViewController.instantiate("Main")
        viewController2.viewModel = FavoritesListViewModel()
        let navController2 = UINavigationController(rootViewController: viewController2)
        navController2.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "icons8-star-30"), tag: 1)

        setViewControllers([navController1, navController2], animated: true)
    }
    
}
