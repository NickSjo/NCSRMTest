//
//  FavoritesCacheTest.swift
//  NCSRMTestTests
//
//  Created by Niklas S on 2019-08-18.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import XCTest
@testable import NCSRMTest

class FavoritesCacheTest: XCTestCase {

    var cache: FavoritesCache!
    
    override func setUp() {
        cache = FavoritesCache()
    }
    
    func testAddFavorites() {
        XCTAssertTrue(cache.favorites.isEmpty)
        
        let character1 = testCharacter1
        let result1 = cache.add(character1)
        
        XCTAssertTrue(result1.0)
        XCTAssertTrue(cache.favorites.count == 1)
        XCTAssertTrue(cache.favorites.contains(character1))
        
        let character2 = testCharacter2
        let result2 = cache.add(character2)
        
        XCTAssertTrue(result2.0)
        XCTAssertTrue(cache.favorites.count == 2)
        XCTAssertTrue(cache.favorites.contains(character2))
    }

    func testAddDuplicateFavorite() {
        XCTAssertTrue(cache.favorites.isEmpty)
        
        let character = testCharacter1
        _ = cache.add(character)
        XCTAssertTrue(cache.favorites.count == 1)
        XCTAssertTrue(cache.favorites.contains(character))
        
        let result = cache.add(character)
        XCTAssertFalse(result.0)
        XCTAssertTrue(cache.favorites.count == 1)
    }
    
    func testRemoveFavorite() {
        XCTAssertTrue(cache.favorites.isEmpty)
        
        let character = testCharacter1
        _ = cache.add(character)
        XCTAssertTrue(cache.favorites.count == 1)
        XCTAssertTrue(cache.favorites.contains(character))
        
        let result = cache.remove(character)
        XCTAssertTrue(result)
        XCTAssertTrue(cache.favorites.count == 0)
    }
    
    func testReset() {
        XCTAssertTrue(cache.favorites.isEmpty)
        
        let character1 = testCharacter1
        let character2 = testCharacter2
        
        _ = cache.add(character1)
        _ = cache.add(character2)
        XCTAssertTrue(cache.favorites.count == 2)
        
        cache.reset()
        
        XCTAssertTrue(cache.favorites.isEmpty)
    }
}

private extension FavoritesCacheTest {
    
    var testCharacter1: Character {
        let location = Location(name: "location1", url: "", type: nil, dimension: nil, residents: nil, created: nil)
        let origin = Origin(name: "origin1", url: "")
        
        return Character(id: 1, name: "Character1", origin: origin, location: location, image: "")
    }
    
    var testCharacter2: Character {
        let location = Location(name: "location1", url: "", type: nil, dimension: nil, residents: nil, created: nil)
        let origin = Origin(name: "origin1", url: "")
        
        return Character(id: 2, name: "Character1", origin: origin, location: location, image: "")
    }
    
}
