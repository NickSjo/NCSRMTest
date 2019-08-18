//
//  CharacterDetailsViewController.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-18.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController, StoryboardInstantiated {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var originLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var favoritesButton: UIButton!
    @IBOutlet private weak var imageActivityIndicator: UIActivityIndicatorView!
    
    var viewModel: CharacterDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
        
        updateUI()
    }

}

extension CharacterDetailsViewController { // MARK: Actions
    
    @IBAction func didSelectLocationAction(_ sender: Any) {
        let vc = LocationDetailsViewController.instantiate("Main")
        vc.viewModel = LocationDetailsViewModel(viewModel.location)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addToFavoritesAction(_ sender: Any) {
        viewModel.addToFavorites()
    }
    
}

private extension CharacterDetailsViewController { // MARK: Private
    
    func updateUI() {
        nameLabel.text = viewModel.name
        originLabel.text = viewModel.originName
        locationLabel.text = viewModel.locationName
        
        imageActivityIndicator.startAnimating()
        viewModel.loadImage { [weak self] image in
            guard let self = self else { return }
            self.imageActivityIndicator.stopAnimating()
            UIView.transition(with: self.view, duration: 0.2, options: .transitionCrossDissolve, animations: { [weak self] in
                self?.imageView.image = image
            }, completion: nil)
        }
    }
    
}
