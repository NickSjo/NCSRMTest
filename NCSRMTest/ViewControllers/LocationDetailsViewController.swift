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
    
    var viewModel: LocationDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.load()
        viewModel.didUpdate = { [weak self] in
            self?.updateUI()
        }
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
    
    func updateUI() {
        nameLabel.text = viewModel.name
        typeLabel.text = viewModel.type
        dimensionLabel.text = viewModel.dimension
    }
    
}
