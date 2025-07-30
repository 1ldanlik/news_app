//
//  FavouriteNewsListView.swift
//  news_app
//
//  Created by Ildan on 19.07.2025.
//

import SwiftUI

struct FavouriteNewsListView: View {
    @StateObject private var viewModel = FavouriteNewsDetailsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.articles) { article in
                    NavigationLink(destination: NewsDetailView(article: article)) {
                        VStack(alignment: .leading) {
                            Text(article.title ?? "").font(.headline)
                            Text(article.description ?? "").font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteArticles)
            }
            .navigationTitle("Favourite articles")
            .task {
                viewModel.fetchTeslaNews()
            }
        }
    }
    
    private func deleteArticles(at offsets: IndexSet) {
        offsets.forEach { index in
            let article = viewModel.articles[index]
            viewModel.deleteArticle(article: article)
        }
    }
}

#Preview {
    FavouriteNewsListView()
}
