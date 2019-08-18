//
//  RESTClient.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import Foundation

enum RESTClientResult<Value> {
    case success(Value)
    case failure(Error)
}

class RESTClient {
    
    static let shared = RESTClient()
    
    func performDataTask<T: Decodable>(with url: String, _ completion: @escaping (RESTClientResult<T>) -> Void) {
        HTTPClient.shared.performDataTask(for: url) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(RESTClientResult.success(response))
                } catch (let error) {
                    completion(RESTClientResult.failure(error))
                }
            case .failure:
                break
            }
        }
    }
    
}
