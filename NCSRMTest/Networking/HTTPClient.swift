//
//  HTTPClient.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import Foundation

enum HTTPClientError: Error {
    case invalidData
    case invalidURL
    case unexpedStatusCodeError(statusCode: Int)
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return "Error: Invalid data"
        case .invalidURL:
            return "Error: Invalid URL"
        case .unexpedStatusCodeError(let statusCode):
            return "Error: unexpected status code \(statusCode)"
        case .unknownError:
            return "An unknown error occured"
        }
    }
}

enum HTTPResult<Value> {
    case success(Value)
    case failure(Error)
}

class HTTPClient {
    static let shared = HTTPClient()
    private var session = URLSession(configuration: .default)
    
    func performDataTask(for url: String, _ completion: @escaping (HTTPResult<Data>) -> Void) {
        guard let url = URL(string: url) else {
            completion(HTTPResult.failure(HTTPClientError.invalidURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        print("GET request to \(url)")
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(HTTPResult.failure(error))
                } else if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        if let data = data {
                            completion(HTTPResult.success(data))
                        } else {
                            completion(HTTPResult.failure(HTTPClientError.invalidData))
                        }
                    } else {
                        completion(HTTPResult.failure(HTTPClientError.unexpedStatusCodeError(statusCode: response.statusCode)))
                    }
                } else {
                    completion(HTTPResult.failure(HTTPClientError.unknownError))
                }
                print("GET request to \(url) done!")
            }
        }
        
        task.resume()
    }
    
}
