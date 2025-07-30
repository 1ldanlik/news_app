//
//  NewsDetailsViewModel.swift
//  news_app
//
//  Created by Ildan on 15.07.2025.
//

import Foundation
import Combine

@MainActor
class NewsDetailsViewModel: ObservableObject {
    private let article: Article
    @Published var isArticleInCache: Bool = false
    
    init(article: Article) {
        self.article = article
        checkIfArticleInCache(url: article.url)
    }
    
    private let storageService = NewsStorageService.shared
    private var cancellables = Set<AnyCancellable>()
    
    func onFavouriteButtonPressed() {
        if isArticleInCache {
            storageService.deleteByUrl(byURL: article.url)
            isArticleInCache = false
        } else {
            storageService.saveArticle(article)
            isArticleInCache = true
        }
    }
    
    func checkIfArticleInCache(url: String) {
        isArticleInCache = storageService.isArticleInCache(url: url)
    }
}
