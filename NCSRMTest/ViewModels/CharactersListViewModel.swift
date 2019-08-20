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
    var emptyMessage: String
    var errorMessage: String
    var title: String
    var didUpdate: ((Error?, Bool) -> Void)?
    
    var numberOfItems: Int {
        return characters.count
    }
    
    private var characters: [Character]
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
        emptyMessage = "No characters"
        errorMessage = "Error. Could not fetch characters"
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
    
    func character(for indexPath: IndexPath) -> Character {
        return characters[indexPath.row]
    }
    
    func characterName(for indexPath: IndexPath) -> String {
        return characters[indexPath.row].name
    }
}

private extension CharactersListViewModel {
    
    func load(with url: String) {
        guard isLoading == false else {
            return
        }
        
        isLoading = true
        JSONClient.shared.performDataTask(with: url) { [weak self] (result: JSONClientResult<CharactersResponse>) in
            self?.isLoading = false
            self?.update(for: url, result)
        }
    }
    
    func update(for url: String, _ result: JSONClientResult<CharactersResponse>) {
        switch result {
        case .success(let charactersResponse):
            info = charactersResponse.info
            
            if url == baseURL {
                // We are at first page, replace characters array
                characters = charactersResponse.results
            } else {
                // We are not at first page, append new data
                characters.append(contentsOf: charactersResponse.results)
            }
            
            didUpdate?(nil, hasMorePages)
        case .failure(let error):
            info = nil
            didUpdate?(error, false)
        }
    }
}

