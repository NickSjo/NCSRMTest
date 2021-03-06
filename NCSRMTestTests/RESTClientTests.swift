//
//  RESTClientTests.swift
//  NCSRMTestTests
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import XCTest
@testable import NCSRMTest

class RESTClientTests: XCTestCase {

    var jsonClient: JSONClient!
    
    override func setUp() {
        jsonClient = JSONClient()
    }

    func testGetAndParseCharactersResponse() {
        let e = expectation(description: "Test get characters")
        
        jsonClient.performDataTask(with: "https://rickandmortyapi.com/api/character/") { (result: JSONClientResult<CharactersResponse>) in
            switch result {
            case .success(let response):
                XCTAssert(response.results.count > 0)
                e.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 60.0, handler: nil)
    }

}
