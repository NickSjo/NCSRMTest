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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 60.0;
        
        title = viewModel.title
        
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
        cell.selectionStyle = viewModel.allowsItemDetails ? UITableViewCell.SelectionStyle.default : UITableViewCell.SelectionStyle.none
        cell.accessoryType = viewModel.allowsItemDetails ? UITableViewCell.AccessoryType.disclosureIndicator : UITableViewCell.AccessoryType.none
        
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
                self?.viewModel.delete(for: indexPath)
            }
            editActions.append(deleteAction)
        }
        
        return editActions
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.allowsItemDetails else {
            return
        }
        
        let character = viewModel.characters[indexPath.row]
        let vc = CharacterDetailsViewController.instantiate("Main")
        vc.viewModel = CharacterDetailsViewModel(character)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

private extension ListTableViewController { // MARK: Private
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl?.tintColor = .black
    }
    
    @objc func refreshData() {
        viewModel.refresh()
        refreshControl?.endRefreshing()
    }
    
    func updateTableViewContent(with previousSnapshot: [Character], _ targetSnapshot: [Character], _ hasMorePages: Bool) {
//        var deletedItems: [IndexPath] = []
//        if targetSnapshot.count < previousSnapshot.count {
//            let changes = (targetSnapshot.count..<previousSnapshot.count).map({ IndexPath(row: $0, section: 0) })
//            deletedItems.append(contentsOf: changes)
//        }
//
//        var insertedItems: [IndexPath] = []
//        if targetSnapshot.count > previousSnapshot.count {
//            let changes = (previousSnapshot.count..<targetSnapshot.count).map({ IndexPath(row: $0, section: 0) })
//            insertedItems.append(contentsOf: changes)
//        }
//
//        tableView.beginUpdates()
//        tableView.insertRows(at: insertedItems, with: .none)
//        tableView.deleteRows(at: deletedItems, with: .none)
//        tableView.endUpdates()
        
        tableView.reloadData()
        tableView.tableFooterView?.isHidden = (hasMorePages == false)
    }
    
}
