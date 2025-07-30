//
//  ArticleEntity+Mapping.swift
//  news_app
//
//  Created by Ildan on 19.07.2025.
//

import Foundation

extension ArticleEntity {
    func toArticle() -> Article {
        Article(
            source: Source(id: self.sourceId, name: self.sourceName ?? ""),
            author: self.author,
            title: self.title,
            description: self.desc,
            url: self.url ?? "",
            urlToImage: self.urlToImage,
            publishedAt: self.publishedAt ?? "",
            content: self.content
        )
    }
}
