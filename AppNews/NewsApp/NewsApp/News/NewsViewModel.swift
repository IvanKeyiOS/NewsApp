//
//  DetailViewModel.swift
//  NewsApp
//
//  Created by Иван Курганский on 26/01/2025.
//

import Foundation

protocol NewsViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var date: String { get }
    var imageData: Data? { get }
    
}

final class NewsViewModel: NewsViewModelProtocol {
    var title: String
    
    var description: String
    
    var date: String
    
    var imageData: Data?
    
    init(article: ArticleCellViewModel) {
        title = article.title
        description = article.description
        date = article.data
        imageData = article.imageData
    }
}
