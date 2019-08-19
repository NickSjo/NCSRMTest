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
    var emptyMessage: String
    var errorMessage: String
    var title: String
    var didUpdate: ((Error?, Bool) -> Void)?
    
    var numberOfItems: Int {
        return characters.count
    }
    
    private var characters: [Character]
    private var location: Location
    private let baseURL = "https://rickandmortyapi.com/api/character/"
    private var isLoading: Bool
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
        allowsRefresh = true
        emptyMessage = "No residents"
        errorMessage = "Error. Could not fetch residents"
        title = "Residents"
        characters = []
        isLoading = false
        
        self.location = location
    }
    
    func load() {
        guard isLoading == false else {
            return
        }
        
        isLoading = true
        
        let url = baseURL.appending("[\(residentIDs.joined(separator: ","))]")
        RESTClient.shared.performDataTask(with: url) { [weak self] (result: RESTClientResult<[Character]>) in
            self?.isLoading = false
            
            switch result {
            case .success(let characters):
                self?.characters = characters
                self?.didUpdate?(nil, false)
            case .failure(let error):
                self?.didUpdate?(error, false)
            }
        }
    }
    
    func loadNextPage() {
        //  Not supported
    }
    
    func refresh() {
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

