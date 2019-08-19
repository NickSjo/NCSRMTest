//
//  ListTableViewController.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, StoryboardInstantiated {

    @IBOutlet private weak var tableFooterActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableFooterMessageLabel: UILabel!
    
    
    var viewModel: ListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .backgroundColor
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 65.0;
        
        title = viewModel.title
        
        if viewModel.allowsRefresh {
            setupRefreshControl()
        }
        viewModel.didUpdate = { [weak self] (error, hasMorePages) in
            self?.updateTableViewContent(error, hasMorePages)
        }
        viewModel.load()
    }

}

extension ListTableViewController { // MARK: Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        cell.nameLabel.text = viewModel.characterName(for: indexPath)
        cell.selectionStyle = viewModel.allowsItemDetails ? UITableViewCell.SelectionStyle.default : UITableViewCell.SelectionStyle.none
        cell.accessoryType = viewModel.allowsItemDetails ? UITableViewCell.AccessoryType.disclosureIndicator : UITableViewCell.AccessoryType.none
        cell.accessoryView = TintedImageView(image: UIImage(named: "ico_arrow"))
        
        if viewModel.allowsPagination, indexPath.row == viewModel.numberOfItems - 1 {
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
            deleteAction.backgroundColor = .warningColor
            editActions.append(deleteAction)
        }
        
        return editActions
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.allowsItemDetails else {
            return
        }
        
        let character = viewModel.character(for: indexPath)
        let vc = CharacterDetailsViewController.instantiate("Main")
        vc.viewModel = CharacterDetailsViewModel(character)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

private extension ListTableViewController { // MARK: Private
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl?.tintColor = .white
    }
    
    @objc func refreshData() {
        viewModel.refresh()
    }
    
    func updateTableViewContent(_ error: Error?, _ hasMorePages: Bool) {
        var footerVisibile = false
        
        if let _ = error {
            tableFooterActivityIndicator.stopAnimating()
            tableFooterMessageLabel.text = viewModel.errorMessage
            footerVisibile = true
        } else {
            if viewModel.numberOfItems == 0 {
                tableFooterActivityIndicator.stopAnimating()
                tableFooterMessageLabel.text = viewModel.emptyMessage
                footerVisibile = true
            } else {
                tableFooterActivityIndicator.startAnimating()
                tableFooterMessageLabel.text = nil
                footerVisibile = (hasMorePages == true)
            }
        }
        
        if tableView.refreshControl?.isRefreshing ?? false {
            DispatchQueue.main.async { [weak self] in
                self?.refreshControl?.endRefreshing()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.tableView.reloadData()
            self?.updateFooterViewVisibility(footerVisibile)
        }
    }
    
    func updateFooterViewVisibility(_ visible: Bool) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.tableView.tableFooterView?.alpha = visible ? 1.0 : 0.0
        }
    }
    
}
