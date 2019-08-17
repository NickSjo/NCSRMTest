//
//  HTTPClientTests.swift
//  NCSRMTestTests
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import XCTest
@testable import NCSRMTest

class HTTPClientTests: XCTestCase {

    func testGetRequest() {
        let e = expectation(description: "Test get request")
        
        HTTPClient.shared.performDataTask(for: "https://rickandmortyapi.com/api/character/") { result in
            switch result {
            case .success:
                e.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 60.0, handler: nil)
    }

    func testInvalidURL() {
        let e = expectation(description: "Test invalid URL")
        
        HTTPClient.shared.performDataTask(for: "") { result in
            if case let .failure(error) = result, case HTTPClientError.invalidURL = error {
                e.fulfill()
            } else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 60.0, handler: nil)
    }
    
    func testUnexpectedStatusCode() {
        let e = expectation(description: "Test unexpected status codes")
        
        HTTPClient.shared.performDataTask(for: "https://rickandmortyapi.com/api/character/invalidcharacters") { result in
            if case let .failure(error) = result, case HTTPClientError.unexpedStatusCodeError(statusCode: 500) = error {
                e.fulfill()
            } else {
                XCTFail()
            }
        }
        
        HTTPClient.shared.performDataTask(for: "https://rickandmortyapi.com/api/character/10000000") { result in
            if case let .failure(error) = result, case HTTPClientError.unexpedStatusCodeError(statusCode: 404) = error {
                e.fulfill()
            } else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 60.0, handler: nil)
    }
}
