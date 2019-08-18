//
//  LocationDetailsViewController.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-18.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController, StoryboardInstantiated {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var dimensionLabel: UILabel!
    @IBOutlet private weak var residentsButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    var viewModel: LocationDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = viewModel.title
        
        viewModel.didUpdate = { [weak self] status in
            self?.updateUI(for: status)
        }
        viewModel.load()
    }

}

extension LocationDetailsViewController { // MARK: Actions
    
    @IBAction func showResidentsAction(_ sender: Any) {
        let vc = ListTableViewController.instantiate("Main")
        vc.viewModel = ResidentsListViewModel(viewModel.location)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

private extension LocationDetailsViewController { // MARK: Private
    
    func updateUI(for status: LocationDetailsViewModelStatus) {
        switch status {
        case .initial, .loading:
            nameLabel.text = " "
            typeLabel.text = " "
            dimensionLabel.text = " "
            residentsButton.isEnabled = false
            scrollView.alpha = 0.0
            activityIndicator.startAnimating()
        case .loaded(_):
            nameLabel.text = viewModel.name
            typeLabel.text = viewModel.type ?? "unknown"
            dimensionLabel.text = viewModel.dimension ?? "unknown"
            residentsButton.isEnabled = true
            scrollView.alpha = 1.0
            activityIndicator.stopAnimating()
        }
        

    }
    
}
