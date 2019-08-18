//
//  ImageCache.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-18.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit


class ImageCache {
    static let shared = ImageCache()
    
    private(set) var images: [String: UIImage]
    
    init() {
        images = [:]
    }
    
    func image(for url: String, completion: @escaping (UIImage?) -> Void) {
        // Check if image is already stored in dictionary!
        if let image = images[url] {
            completion(image)
        } else {
            HTTPClient.shared.performDataTask(for: url) { [weak self] result in
                switch result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        self?.images[url] = image
                        completion(image)
                    } else {
                        completion(nil)
                    }
                case .failure:
                    completion(nil)
                }
            }
        }
    }
}
