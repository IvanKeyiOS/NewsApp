//
//  GeneralViewModel.swift
//  NewsApp
//
//  Created by Иван Курганский on 25/01/2025.
//

import Foundation

final class GeneralViewModel: NewsListViewModel {
    override func loadData() {
        super.loadData()
        
        ApiManager.getNews(from: .general, page: page) { [weak self] result in
            self?.handleResult(result)
        }
    }
}
