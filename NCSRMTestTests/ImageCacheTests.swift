//
//  ImageCacheTests.swift
//  NCSRMTestTests
//
//  Created by Niklas S on 2019-08-18.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import XCTest
@testable import NCSRMTest

class ImageCacheTests: XCTestCase {

    func testCacheStorage() {
        let e = expectation(description: "Test that fetched image is stored in in memory cache")
        let url = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        
        ImageCache.shared.image(for: url) { (image) in
            if let image = image, let imageData = image.pngData(),
                let cachedImage = ImageCache.shared.images[url], let cachedImageData = cachedImage.pngData() {
                XCTAssertTrue(imageData == cachedImageData)
                e.fulfill()
            } else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 60.0, handler: nil)
    }

    
}
