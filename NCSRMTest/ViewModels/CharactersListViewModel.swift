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
    var characters: [Character]
    var didUpdate: (() -> Void)?
    
    private var info: Info?
    private let baseURL = "https://rickandmortyapi.com/api/character/"
    
    init() {
        allowsDeletion = false
        allowsItemDetails = true
        allowsPagination = true
        allowsRefresh = true
        characters = []
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
    
    func delete() {
        // Not supported
    }
}

private extension CharactersListViewModel {
    
    func load(with url: String) {
        RESTClient().performDataTask(with: url) { [weak self] (result: RESTClientResult<CharactersResponse>) in
            switch result {
            case .success(let charactersResponse):
                self?.info = charactersResponse.info
                if url == self?.baseURL {
                    // We are at first page, replace characters array
                    self?.characters = charactersResponse.results
                } else {
                    // We are not at first page, append new data
                    self?.characters.append(contentsOf: charactersResponse.results)
                }
                self?.didUpdate?()
            case .failure:
                self?.didUpdate?()
            }
        }
    }
    
}

