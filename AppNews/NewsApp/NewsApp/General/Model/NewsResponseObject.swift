//
//  NewsResponseObject.swift
//  NewsApp
//
//  Created by Иван Курганский on 25/01/2025.
//

import Foundation

struct NewsResponseObject: Codable {
    let totalResults: Int
    let articles: [ArticleResponseObject]
    
    enum CodingKeys: CodingKey {
        case totalResults
        case articles
    }
}
