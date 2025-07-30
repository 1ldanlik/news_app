//
//  FavouriteNewsViewModel.swift
//  news_app
//
//  Created by Ildan on 19.07.2025.
//

import Foundation
import Combine

@MainActor
class FavouriteNewsDetailsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var error: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let storageService = NewsStorageService.shared
    
    func fetchTeslaNews() {
        articles = storageService.fetchArticles()
    }
    
    func deleteArticle(article: Article) {
        storageService.deleteByUrl(byURL: article.url)
    }
}
