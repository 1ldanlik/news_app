//
//  RxNewsViewModelAdapter.swift
//  news_app
//
//  Created by Ildan on 28.07.2025.
//

import Foundation
import Combine
import RxSwift

@MainActor
final class RxNewsViewModelAdapter: ObservableObject {
    @Published var articles: [Article] = []
    @Published var error: String?
    
    private let viewModel = NewsViewModel()
    private let disposeBag = DisposeBag()
    
    init() {
        viewModel.articles
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in self?.articles = $0 })
            .disposed(by: disposeBag)
        
        viewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in self?.error = $0 })
            .disposed(by: disposeBag)
    }
    
    func fetchTeslaNews() {
        viewModel.fetchTeslaNews()
    }
}
