//
//  Article.swift
//  news_app
//
//  Created by Ildan on 13.07.2025.
//

import Foundation

struct Article: Identifiable, Decodable {
    var id: String { url } // Можно использовать url как уникальный ID
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}
