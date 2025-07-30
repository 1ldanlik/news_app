//
//  NewsListView.swift
//  news_app
//
//  Created by Ildan on 12.07.2025.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = RxNewsViewModelAdapter()
    
    var body: some View {
        NavigationView {
            List(viewModel.articles) { article in
                NavigationLink(destination: NewsDetailView(article: article)) {
                    VStack(alignment: .leading) {
                        Text(article.title ?? "")
                            .font(.headline)
                        Text(article.description ?? "")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Tesla News")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: FavouriteNewsListView()) {
                        Image(systemName: "star.fill")
                            .imageScale(.large)
                            .foregroundColor(.yellow)
                    }
                }
            }
            .task {
                viewModel.fetchTeslaNews()
            }
            .alert(item: Binding(
                get: { viewModel.error.map { LocalizedErrorWrapper(message: $0) } },
                set: { _ in viewModel.error = nil }
            )) { error in
                Alert(title: Text("Error"), message: Text(error.message))
            }
        }
    }
}

#Preview {
    NewsListView()
}
