//
//  RESTClient.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import Foundation

enum JSONClientResult<Value> {
    case success(Value)
    case failure(Error)
}

class JSONClient {
    
    static let shared = JSONClient()
    
    func performDataTask<T: Decodable>(with url: String, _ completion: @escaping (JSONClientResult<T>) -> Void) {
        HTTPClient.shared.performDataTask(for: url) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(JSONClientResult.success(response))
                } catch (let error) {
                    completion(JSONClientResult.failure(error))
                }
            case .failure(let error):
                completion(JSONClientResult.failure(error))
            }
        }
    }
    
}
