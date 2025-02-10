//
//  TechnologyViewModel.swift
//  NewsApp
//
//  Created by Иван Курганский on 08/02/2025.
//

final class TechnologyViewModel: NewsListViewModel {
    override func loadData(searchText: String?) {
        super.loadData(searchText: searchText)
        
        ApiManager.getNews(from: .technology,
                           page: page,
                           searchText: searchText) { [weak self] result in
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
