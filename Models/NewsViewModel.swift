//
//  NewsViewModel.swift
//  news_app
//
//  Created by Ildan on 13.07.2025.
//

import Foundation
import RxSwift
import RxCocoa

@MainActor
class NewsViewModel {
    let articles = BehaviorRelay<[Article]>(value: [])
    let error = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    
    func fetchTeslaNews() {
        NewsRepository.shared.fetchNews(query: "tesla")
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    self?.articles.accept(response.articles)
                },
                onError: { [weak self] err in
                    self?.error.accept(err.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    
    let searchText = BehaviorRelay<String>(value: "")
    
    lazy var filteredArticles: Observable<[Article]> = {
        Observable.combineLatest(articles, searchText)
            .map { articles, query in
                guard !query.isEmpty else { return articles }
                return articles.filter {
                    $0.title?.lowercased().contains(query.lowercased()) ?? false
                }
            }
    }()
}

