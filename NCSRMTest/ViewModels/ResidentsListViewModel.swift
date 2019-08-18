//
//  ResidentsListViewModel.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-18.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit


class ResidentsListViewModel: ListViewModel {
    var allowsDeletion: Bool
    var allowsItemDetails: Bool
    var allowsPagination: Bool
    var allowsRefresh: Bool
    var didUpdate: (([Character], [Character], Bool) -> Void)?
    var characters: [Character]
    
    private var location: Location
    private let baseURL = "https://rickandmortyapi.com/api/character/"
    private var residentIDs: [String] {
        guard let residents = location.residents else {
            return []
        }

        return residents.map({ URL(string: $0)?.lastPathComponent }).compactMap({ $0 })
    }
    
    init(_ location: Location) {
        allowsDeletion = false
        allowsItemDetails = true
        allowsPagination = false
        allowsRefresh = false
        characters = []
        
        self.location = location
    }
    
    func load() {
        guard residentIDs.count > 0 else {
            update([])
            return
        }
        
        let url = baseURL.appending("[\(residentIDs.joined(separator: ","))]")
        RESTClient.shared.performDataTask(with: url) { [weak self] (result: RESTClientResult<[Character]>) in
            switch result {
            case .success(let characters):
                self?.update(characters)
            case .failure:
                break
            }
        }
    }
    
    func loadNextPage() {
        //  Not supported
    }
    
    func refresh() {
        //  Not supported
    }
    
    func delete() {
        // Not supported
    }
    
}

private extension ResidentsListViewModel {
    
    func update(_ response: [Character]) {
        let prev = characters
        characters = response
        let target = characters
        
        didUpdate?(prev, target, false)
    }
    
}
