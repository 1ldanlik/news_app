//
//  ArticleModel.swift
//  news_app
//
//  Created by Ildan on 14.07.2025.
//

import Foundation

struct ArticleModel: Identifiable, Codable {
    let id: String
    let title: String?
    let description: String?
    let author: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    let sourceId: String
    let sourceName: String?
    var isFavorite: Bool = false
}
