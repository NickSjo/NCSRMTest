//
//  ListViewModel.swift
//  NCSRMTest
//
//  Created by Niklas S on 2019-08-17.
//  Copyright © 2019 Niklas S. All rights reserved.
//

import UIKit

protocol ListViewModel {
    func load()
    func loadNextPage()
    func refresh()
    func delete(for indexPath: IndexPath)
    func character(for indexPath: IndexPath) -> Character
    func characterName(for indexPath: IndexPath) -> String
    
    var allowsDeletion: Bool { get }
    var allowsItemDetails: Bool { get }
    var allowsPagination: Bool { get }
    var allowsRefresh: Bool { get }
    var title: String { get }
    var emptyMessage: String { get }
    var errorMessage: String { get }
    var didUpdate: ((Error?, _ hasMorePages: Bool) -> Void)? { get set }
    var numberOfItems: Int { get }
}
