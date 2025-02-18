//
//  ApiManager.swift
//  NewsApp
//
//  Created by Иван Курганский on 25/01/2025.
//
import Foundation

final class ApiManager {
    enum Category: String {
        case general = "general"
        case business = "business"
        case technology = "technology"
        case sports = "sports"
    }
    private static let apiKey = "a83170dee91a4376840d9c4e97f5569d"
    private static let baseUrl = "https://newsapi.org/v2/"
    private static let path = "top-headlines"

    //MARK: - Create url path and make request
    static func getNews(from category: Category,
                        completion: @escaping (Result<[ArticleResponseObject], Error>) ->()) {
        let stringUrl = baseUrl + path + "?category=\(category.rawValue)&language=en" + "&apiKey=\(apiKey)"
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            handlerResponse(data: data,
                            error: error,
                            completion: completion)
        }
        session.resume()
    }

    static func getImageData(url: String, completion: @escaping (Result<Data, Error>) ->()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                completion(.success(data))
            }
            if let error = error {
                completion(.failure(error))
            }
        }
        session.resume()
    }
    
    //MARK: - Handle response
    private static func handlerResponse(data: Data?,
                                        error: Error?,
                                        completion: @escaping (Result<[ArticleResponseObject], Error>) ->()) {
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print(json ?? "")
            do {
                let model = try JSONDecoder().decode(NewsResponseObject.self,
                                                     from: data)
                completion(.success(model.articles))
            }
            catch let decoderError {
                completion(.failure(decoderError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }

    }
}
