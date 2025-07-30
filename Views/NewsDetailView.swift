//
//  NewsDetailView.swift
//  news_app
//
//  Created by Ildan on 14.07.2025.
//

import SwiftUI

struct NewsDetailView: View {
    let article: Article
    @StateObject private var viewModel: NewsDetailsViewModel
    
    init(article: Article) {
        self.article = article
        _viewModel = StateObject(wrappedValue: NewsDetailsViewModel(article: article))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(article.title ?? "No title available.")
                .font(.title)
                .fontWeight(.bold)
            
            Text(article.description ?? "No description available.")
                    .font(.body)
                    .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle("News Detail")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.onFavouriteButtonPressed()
                }) {
                    Image(systemName: viewModel.isArticleInCache ? "star.fill" : "star")
                        .foregroundColor(viewModel.isArticleInCache ? .yellow : .primary)
                }
            }
        }.task {
            
        }
    }
}

#Preview {
    NavigationView {
        NewsDetailView(
            article:Article(
                source: Source(id: "techcrunch", name: "TechCrunch"),
                author: "John Doe",
                title: "Sample News Title",
                description: "This is a sample description of the news article. It gives more detail about the content.",
                url: "https://example.com/news/sample-news",
                urlToImage: "https://example.com/images/sample.jpg",
                publishedAt: "2025-07-19T12:34:56Z",
                content: "This is the full content of the sample news article. It goes into more detail about the topic discussed."
            )
        )
    }
}
