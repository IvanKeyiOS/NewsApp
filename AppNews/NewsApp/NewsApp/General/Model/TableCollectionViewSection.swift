//
//  TableCollectionViewSection.swift
//  NewsApp
//
//  Created by Иван Курганский on 09/02/2025.
//

import Foundation

protocol TableCollectionViewItemsProtocol { }

struct TableCollectionViewSection {
    var title: String?
    var items: [TableCollectionViewItemsProtocol]
}
