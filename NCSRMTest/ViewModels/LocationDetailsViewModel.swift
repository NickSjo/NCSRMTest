//
//  LocationDetailsViewModel.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-18.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

enum LocationDetailsViewModelStatus {
    case initial
    case loading
    case loaded(Error?)
}

class LocationDetailsViewModel {
    var title: String {
        return "Location details"
    }
    var name: String {
        return location.name
    }
    var type: String? {
        return location.type
    }
    var dimension: String? {
        return location.dimension
    }
    
    var didUpdate: ((LocationDetailsViewModelStatus) -> Void)?
    
    private(set) var location: Location
    private var status: LocationDetailsViewModelStatus
    
    init(_ location: Location) {
        self.location = location
        self.status = .initial
    }
    
    func load() {
        status = .loading
        notifyObserver()
        
        RESTClient.shared.performDataTask(with: location.url) { [weak self] (result: RESTClientResult<Location>) in
            switch result {
            case .success(let location):
                self?.status = .loaded(nil)
                self?.location = location
                self?.notifyObserver()
            case .failure(let error):
                self?.status = .loaded(error)
                self?.notifyObserver()
            }
        }
    }

}

private extension LocationDetailsViewModel {
    
    func notifyObserver() {
        didUpdate?(status)
    }
    
}
