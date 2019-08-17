//
//  CharactersListViewModel.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

class CharactersListViewModel {
    var characters: [Character]
    var didUpdate: (() -> Void)?
    
    private var info: Info?
    private let baseURL = "https://rickandmortyapi.com/api/character/"
    
    init() {
        characters = []
    }
    
    func load() {
        load(with: baseURL)
    }
}

private extension CharactersListViewModel {
    
    func load(with url: String) {
        RESTClient().performDataTask(with: url) { [weak self] (result: RESTClientResult<CharactersResponse>) in
            switch result {
            case .success(let charactersResponse):
                self?.info = charactersResponse.info
                self?.characters = charactersResponse.results
                self?.didUpdate?()
            case .failure:
                self?.didUpdate?()
            }
        }
    }
    
}

