//
//  ListTableViewController.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, StoryboardInstantiated {

    var viewModel: ListViewModel!
    
    private var dataSourceSnapshot: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 61.0;
        
        if viewModel.allowsRefresh {
            setupRefreshControl()
        }
        
        viewModel.didUpdate = { [weak self] (previous, target, hasMorePages) in
            self?.updateTableViewContent(with: previous, target, hasMorePages)
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
        
        if viewModel.allowsPagination, indexPath.row == viewModel.characters.count - 1 {
            viewModel.loadNextPage()
        }
        
        return cell
    }
}

extension ListTableViewController { // MARK: Table view delegate
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var editActions: [UITableViewRowAction] = []
        
        if viewModel.allowsDeletion {
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, indexPath) in
                self?.viewModel.characters.remove(at: indexPath.row)
                self?.tableView.beginUpdates()
                self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                self?.tableView.endUpdates()
            }
            editActions.append(deleteAction)
        }
        
        return editActions
    }
    
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
    
    private func updateTableViewContent(with previousSnapshot: [Character], _ targetSnapshot: [Character], _ hasMorePages: Bool) {
        var deletedItems: [IndexPath] = []
        if targetSnapshot.count < previousSnapshot.count {
            let changes = (targetSnapshot.count..<previousSnapshot.count).map({ IndexPath(row: $0, section: 0) })
            deletedItems.append(contentsOf: changes)
        }

        var insertedItems: [IndexPath] = []
        if targetSnapshot.count > previousSnapshot.count {
            let changes = (previousSnapshot.count..<targetSnapshot.count).map({ IndexPath(row: $0, section: 0) })
            insertedItems.append(contentsOf: changes)
        }
        
        tableView.beginUpdates()
        tableView.insertRows(at: insertedItems, with: .none)
        tableView.deleteRows(at: deletedItems, with: .none)
        tableView.endUpdates()
        
        tableView.tableFooterView?.isHidden = (hasMorePages == false)
    }
    
}
