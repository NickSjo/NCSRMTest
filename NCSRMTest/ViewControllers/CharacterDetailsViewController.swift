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
    @IBOutlet private weak var imageActivityIndicator: UIActivityIndicatorView!
    
    var viewModel: CharacterDetailsViewModel!
    
    private var barButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
        
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleFavoriteTap), for: .touchUpInside)
        barButtonItem = UIBarButtonItem(customView: button)
        
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateFavoriteImage()
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
}

extension CharacterDetailsViewController { // MARK: Actions
    
    @IBAction func didSelectLocationAction(_ sender: Any) {
        let vc = LocationDetailsViewController.instantiate("Main")
        vc.viewModel = LocationDetailsViewModel(viewModel.location)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

private extension CharacterDetailsViewController { // MARK: Private
    
    @objc func handleFavoriteTap() {
        viewModel.addOrRemoveFavorite()
        
        barButtonItem.customView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.barButtonItem.customView?.transform = .identity
            self?.updateFavoriteImage()
        }
    }
    
    func updateFavoriteImage() {
        (barButtonItem.customView as? UIButton)?.setImage(viewModel.favoriteImage, for: .normal)
    }
    
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
