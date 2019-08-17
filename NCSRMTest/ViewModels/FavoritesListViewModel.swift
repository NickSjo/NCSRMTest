//
//  FavoritesListViewModel.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import Foundation


class FavoritesListViewModel: ListViewModel {
    var allowsDeletion: Bool
    var allowsItemDetails: Bool
    var allowsPagination: Bool
    var allowsRefresh: Bool
    var didUpdate: (() -> Void)?
    var characters: [Character]
    
    init() {
        allowsDeletion = true
        allowsItemDetails = false
        allowsPagination = false
        allowsRefresh = false
        characters = []
    }
    
    func load() {
        
    }
    
    func loadNextPage() {
        //  Not supported
    }
    
    func refresh() {
        //  Not supported
    }
    
    func delete() {
        
    }
    
}
