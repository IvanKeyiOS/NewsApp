//
//  NetworkingError.swift
//  NewsApp
//
//  Created by Иван Курганский on 25/01/2025.
//

import Foundation

enum NetworkingError: Error {
    case networkingError(_ error: Error)
    case unknown
}
