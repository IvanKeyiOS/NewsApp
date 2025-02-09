//
//  SportsViewModel.swift
//  NewsApp
//
//  Created by Иван Курганский on 08/02/2025.
//

import Foundation

protocol SportsViewModelProtocol {
    var reloadData: (() -> Void)? { get set}
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((Int) -> Void)? { get set }
    
    var numberOfCells: Int { get }
    
    func loadData()
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class SportsViewModel: SportsViewModelProtocol {
    var reloadCell: ((Int) -> Void)?
    var showError: ((String) -> Void)?
    var reloadData: (() -> Void)?
    
    //MARK: - Properties
    var numberOfCells: Int{
        articles.count
    }
    
    private var articles: [ArticleCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    func getArticle(for row: Int) -> ArticleCellViewModel {
        return articles[row]
    }
    
    func loadData() {
        print(#function)
        //TODO: - load Data
        ApiManager.getNews(from: .sports) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                self.articles = self.convertToCellViewModel(articles)
                self.loadImage()
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func loadImage() {
        for (index, article) in articles.enumerated() {
            ApiManager.getImageData(url: article.imageUrl ?? "") { [weak self] result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.articles[index].imageData = data
                        self?.reloadCell?(index)
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                    }
                }
            }
        }
    }
        
    private func convertToCellViewModel(_ articles: [ArticleResponseObject]) -> [ArticleCellViewModel] {
        return articles.map { ArticleCellViewModel(article: $0) }
    }
    
    private func setupMockObject() {
        articles = [
            ArticleCellViewModel(article: ArticleResponseObject(title: "First object title",
                                                                description: "First object description",
                                                                urlToImage: "...",
                                                                date: "25.01.2025"))
        ]
    }
}
