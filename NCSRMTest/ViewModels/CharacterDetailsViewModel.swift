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
    
    private(set) var character: Character
    
    
    init(_ character: Character) {
        self.character = character
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        ImageCache.shared.image(for: character.image) { image in
            completion(image)
        }
    }
    
    func addToFavorites() {
        FavoritesCache.shared.add(character)
    }
    
}
