//
//  BusinessViewModel.swift
//  NewsApp
//
//  Created by Иван Курганский on 07/02/2025.
//

import Foundation

protocol BusinessViewModelProtocol {
    var reloadData: (() -> Void)? { get set}
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((IndexPath) -> Void)? { get set }
    var articles: [TableCollectionViewSection] { get }
    
    func loadData()
}

final class BusinessViewModel: BusinessViewModelProtocol {
    var reloadCell: ((IndexPath) -> Void)?
    var showError: ((String) -> Void)?
    var reloadData: (() -> Void)?
    
    //MARK: - Properties
    private(set) var articles: [TableCollectionViewSection] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    func loadData() {
        print(#function)
        //TODO: - load Data
        ApiManager.getNews(from: .business) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                self.convertToCellViewModel(articles)
                self.loadImage()
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError?(error.localizedDescription)
                }
            }
        }
    }
    
    private func loadImage() {
        //TODO: - get image data
        for (i,section) in articles.enumerated() {
            for (index, item) in section.items.enumerated() {
                if let article = item as? ArticleCellViewModel,
                   let url = article.imageUrl {
                    ApiManager.getImageData(url: article.imageUrl ?? "") { [weak self] result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let data):
                                if let article = self?.articles[i].items[index] as? ArticleCellViewModel {
                                    article.imageData = data
                                }
                                self?.reloadCell?(IndexPath(row: index, section: i))
                            case .failure(let error):
                                self?.showError?(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
        
    private func convertToCellViewModel(_ articles: [ArticleResponseObject]) {
        var viewModels = articles.map { ArticleCellViewModel(article: $0) }
        let firstSection = TableCollectionViewSection(items: [viewModels.removeFirst()])
        let secondSection = TableCollectionViewSection(items: viewModels)
        self.articles = [firstSection, secondSection]
    }
    
    private func setupMockObject() {
        articles = [
            TableCollectionViewSection(items: [ArticleCellViewModel(article: ArticleResponseObject(title: "First object title",
                                                                                                  description: "First object description",
                                                                                                  urlToImage: "...",
                                                                                                  date: "25.01.2025"))])
        ]
    }
}
