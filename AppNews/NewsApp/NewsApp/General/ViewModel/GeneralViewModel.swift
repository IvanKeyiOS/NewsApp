//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Иван Курганский on 25/01/2025.
//

import Foundation

protocol GeneralViewModelProtocol {
    var reloadData: (() -> Void)? { get set}
    var showError: ((String) -> Void)? { get set }
    var reloadCell: ((Int) -> Void)? { get set }
    
    var numberOfCells: Int { get }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class GeneralViewModel: GeneralViewModelProtocol {
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
    
    init() {
        loadData()
    }
    
    func getArticle(for row: Int) -> ArticleCellViewModel {
//        let article = articles[row]
        
//        loadImage(for: row)
        
        return articles[row]
    }
    
    private func loadData() {
        //TODO: - load Data
        ApiManager.getNews { [weak self] result in
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
//        setupMockObject()
    }
    
    private func loadImage() {
        //TODO: - get image data
        //        guard let url = URL(string: articles[row].imageUrl) else { return }
        //        guard let data = try? Data(contentsOf: url) else { return }
//        print(#function)
        
        for (index, article) in articles.enumerated() {
            ApiManager.getImageData(url: article.imageUrl) { [weak self] result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.articles[index].imageData = data
                        self?.reloadCell?(index)
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                        //
                    }
                }
            }
        }
    }
        
//        articles.forEach { article in
//            let index = articles.firstIndex(where: { $0.imageUrl == article.imageUrl })
           
        
       
        //        articles[row].imageData = data
        //        reloadCell?(row)
  
    
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
