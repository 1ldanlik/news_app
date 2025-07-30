//
//  NewsRepository.swift
//  news_app
//
//  Created by Ildan on 13.07.2025.
//

import RxSwift
import RxCocoa
import Foundation

final class NewsRepository {
    static let shared = NewsRepository()
    private init() {}
    private let apiKey = Bundle.main.infoDictionary?["NEWS_API_KEY"] as? String ?? ""
    
    func fetchNews(query: String) -> Observable<NewsResponse> {
        var components = URLComponents(string: "https://newsapi.org/v2/everything")!
        let now = Date()
        
        if let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: now) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: oneMonthAgo)
            
            components.queryItems = [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "from", value: dateString),
                URLQueryItem(name: "sortBy", value: "publishedAt"),
                URLQueryItem(name: "apiKey", value: apiKey)
            ]
        }
        
        guard let url = components.url else {
            return Observable.error(URLError(.badURL))
        }
        
        print("📤 [Request]: \(url)")
        let request = URLRequest(url: url)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(NewsResponse.self, from: data)
            }
    }
}
