//
//  ArticleResponceObject.swift
//  NewsApp
//
//  Created by Иван Курганский on 25/01/2025.
//

import Foundation

struct ArticleResponseObject: Codable {
    let title: String
    let description: String?
    let urlToImage: String?
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlToImage
        case date = "publishedAt"
    }
}
