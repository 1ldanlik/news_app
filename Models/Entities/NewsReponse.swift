//
//  NewsReponse.swift
//  news_app
//
//  Created by Ildan on 13.07.2025.
//

import Foundation

struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}


