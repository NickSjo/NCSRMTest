//
//  Model.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

struct CharactersResponse: Decodable {
    var info: Info
    var results: [Character]
}

struct Character: Decodable {
    var id: Int
    var name: String
    var origin: Origin
    var location: Location
    var image: String
}

struct Location: Decodable {
    var name: String
    var url: String
    var type: String?
    var dimension: String?
    var residents: [String]?
    var created: String?
}

struct Origin: Decodable {
    var name: String
    var url: String
}

struct Info: Codable {
    var count: Int
    var pages: Int
    var next: String
    var prev: String
}
