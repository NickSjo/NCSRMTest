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
    
    var allowsDeletion: Bool { get }
    var allowsItemDetails: Bool { get }
    var allowsPagination: Bool { get }
    var allowsRefresh: Bool { get }
    var title: String { get }
    var didUpdate: ((_ previousSnapshot: [Character], _ targetSnapshot: [Character], _ hasMorePages: Bool) -> Void)? { get set }
    var characters: [Character] { get }
}
