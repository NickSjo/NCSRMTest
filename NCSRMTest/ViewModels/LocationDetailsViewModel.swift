//
//  LocationDetailsViewModel.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-18.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

class LocationDetailsViewModel {
    var name: String {
        return location.name
    }
    var type: String? {
        return location.type
    }
    var dimension: String? {
        return location.dimension
    }
    
    var didUpdate: (() -> Void)?
    
    private(set) var location: Location
    
    init(_ location: Location) {
        self.location = location
    }
    
    func load() {
        RESTClient.shared.performDataTask(with: location.url) { [weak self] (result: RESTClientResult<Location>) in
            switch result {
            case .success(let location):
                self?.location = location
                self?.didUpdate?()
            case .failure:
                break
            }
        }
    }

}
