//
//  CharacterDetailsViewModel.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-18.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

class CharacterDetailsViewModel {
    
    var title: String {
        return "Character details"
    }
    var name: String {
        return character.name
    }
    var originName: String {
        return character.origin.name
    }
    var locationName: String {
        return character.location.name
    }
    var location: Location {
        return character.location
    }
    var favoriteImage: UIImage? {
        return isFavorite ? UIImage(named: "icons8-star_yellow") : UIImage(named: "icons8-star_gray")
    }
    
    private var isFavorite: Bool {
        return FavoritesCache.shared.isFavorite(character)
    }
    
    private(set) var character: Character
    
    
    init(_ character: Character) {
        self.character = character
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        ImageCache.shared.image(for: character.image) { image in
            completion(image)
        }
    }
    
    func addOrRemoveFavorite() {
        if isFavorite {
            FavoritesCache.shared.remove(character)
        } else {
            FavoritesCache.shared.add(character)
        }
    }
    
}
