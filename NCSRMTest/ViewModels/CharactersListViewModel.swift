//
//  CharactersListViewModel.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

class CharactersListViewModel: ListViewModel {
    var allowsDeletion: Bool
    var allowsItemDetails: Bool
    var allowsPagination: Bool
    var allowsRefresh: Bool
    var title: String
    var characters: [Character]
    var didUpdate: (([Character], [Character], Bool) -> Void)?
    
    private var info: Info?
    private let baseURL = "https://rickandmortyapi.com/api/character/"
    private var isLoading: Bool
    
    private var hasMorePages: Bool {
        if let info = info, info.next.count > 0 {
            return true
        }
        
        return false
    }
    
    init() {
        allowsDeletion = false
        allowsItemDetails = true
        allowsPagination = true
        allowsRefresh = true
        title = "Characters"
        characters = []
        isLoading = false
    }
    
    func load() {
        load(with: baseURL)
    }
    
    func loadNextPage() {
        if let info = info, info.next.count > 0 {
            load(with: info.next)
        }
    }
    
    func refresh() {
        info = nil
        load()
    }
    
    func delete(for indexPath: IndexPath) {
        // Not supported
    }
}

private extension CharactersListViewModel {
    
    func load(with url: String) {
        guard isLoading == false else {
            return
        }
        
        isLoading = true
        RESTClient.shared.performDataTask(with: url) { [weak self] (result: RESTClientResult<CharactersResponse>) in
            self?.isLoading = false
            switch result {
            case .success(let charactersResponse):
                self?.update(for: url, charactersResponse)
            case .failure:
                self?.update(for: url, nil)
            }
        }
    }
    
    func update(for url: String, _ charactersResponse: CharactersResponse?) {
        guard let charactersResponse = charactersResponse else {
            info = nil
            let prev = characters
            let target = characters
            didUpdate?(prev, target, false)
            
            return
        }
        
        info = charactersResponse.info
        let prev = characters
        
        if url == baseURL {
            // We are at first page, replace characters array
            characters = charactersResponse.results
        } else {
            // We are not at first page, append new data
            characters.append(contentsOf: charactersResponse.results)
        }
        
        let target = characters
        
        didUpdate?(prev, target, hasMorePages)
    }
}

