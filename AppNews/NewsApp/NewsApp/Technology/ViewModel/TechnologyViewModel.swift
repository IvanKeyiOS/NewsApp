//
//  TechnologyViewModel.swift
//  NewsApp
//
//  Created by Иван Курганский on 08/02/2025.
//

import Foundation

protocol TechnologyViewModelProtocol {
    var reloadData: (() -> Void)? { get set}
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((IndexPath) -> Void)? { get set }
    var sections: [TableCollectionViewSection] { get }
    
    func loadData()
}

final class TechnologyViewModel: TechnologyViewModelProtocol {
    var reloadCell: ((IndexPath) -> Void)?
    var showError: ((String) -> Void)?
    var reloadData: (() -> Void)?
    
    //MARK: - Properties
    private(set) var sections: [TableCollectionViewSection] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    private var page = 0
    
    func loadData() {
        print(#function)
        //TODO: - load Data
        page += 1
        
        ApiManager.getNews(from: .business,
                           page: page,
                           searchText: "searchText") { [weak self] result in
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
        for (i,section) in sections.enumerated() {
            for (index, item) in section.items.enumerated() {
                if let article = item as? ArticleCellViewModel,
                   let url = article.imageUrl {
                    ApiManager.getImageData(url: article.imageUrl ?? "") { [weak self] result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let data):
                                if let article = self?.sections[i].items[index] as? ArticleCellViewModel {
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
        
        if sections.isEmpty {
            let firstSection = TableCollectionViewSection(items: [viewModels.removeFirst()])
            let secondSection = TableCollectionViewSection(items: viewModels)
            sections = [firstSection, secondSection]
        } else {
            sections[1].items += viewModels
        }
    }
    private func setupMockObject() {
        sections = [
            TableCollectionViewSection(items: [ArticleCellViewModel(article: ArticleResponseObject(title: "First object title",
                                                                                                  description: "First object description",
                                                                                                  urlToImage: "...",
                                                                                                  date: "25.01.2025"))])
        ]
    }
}
