//
//  BusinessViewModel.swift
//  NewsApp
//
//  Created by Иван Курганский on 07/02/2025.
//

import Foundation



final class BusinessViewModel: NewsListViewModel {
    override func loadData() {
        super.loadData()
        
        ApiManager.getNews(from: .business, page: page) { [weak self] result in
            self?.handleResult(result)
            }
        }
    
    override func convertToCellViewModel(_ articles: [ArticleResponseObject]) {
        var viewModels = articles.map { ArticleCellViewModel(article: $0) }
        
        if sections.isEmpty {
            let firstSection = TableCollectionViewSection(items: [viewModels.removeFirst()])
            let secondSection = TableCollectionViewSection(items: viewModels)
            sections = [firstSection, secondSection]
        } else {
            sections[1].items += viewModels
        }
    }
    }
