//
//  ListTableViewController.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, StoryboardInstantiated {

    var viewModel: CharactersListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefreshControl()
        
        viewModel.didUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.load()
    }

}

extension ListTableViewController { // MARK: Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        cell.nameLabel.text = viewModel.characters[indexPath.row].name
        
        if indexPath.row == viewModel.characters.count - 1 {
            viewModel.loadNextPage()
        }
        
        return cell
    }
}

extension ListTableViewController { // MARK: Table view delegate
    
    
}

private extension ListTableViewController {
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl?.tintColor = .black
    }
    
    @objc private func refreshData() {
        viewModel.refresh()
        refreshControl?.endRefreshing()
    }
    
}
