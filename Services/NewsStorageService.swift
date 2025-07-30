//
//  NewsStorageService.swift
//  news_app
//
//  Created by Ildan on 14.07.2025.
//

import Foundation
import CoreData

class NewsStorageService {
    static let shared = NewsStorageService()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData load failed: \(error.localizedDescription)")
            }
        }
    }
    
    func saveArticle(_ article: Article) {
        let context = container.viewContext
        
        if isArticleInCache(url: article.url) {
            print("Article already exists in cache.")
            return
        }
        
        let entity = ArticleEntity(context: context)
        entity.articleId = UUID()
        entity.title = article.title
        entity.desc = article.description
        entity.url = article.url
        entity.urlToImage = article.urlToImage
        entity.publishedAt = article.publishedAt
        entity.content = article.content
        entity.sourceId = article.source.id
        entity.sourceName = article.source.name
        
        saveContext()
    }
    
    func fetchArticles() -> [Article] {
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        do {
            return try container.viewContext
                .fetch(request)
                .map { $0.toArticle() }
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }
    
    func isArticleInCache(url: String) -> Bool {
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleEntity")
        request.predicate = NSPredicate(format: "url == %@", url)
        request.fetchLimit = 1
        request.includesPropertyValues = false
        request.resultType = .countResultType
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Fetch error: \(error)")
            return false
        }
    }
    
    func delete(_ article: ArticleEntity) {
        container.viewContext.delete(article)
        saveContext()
    }
    
    func deleteByUrl(byURL url: String) {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ArticleEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", url)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Ошибка при удалении статьи: \(error)")
        }
    }
    
    private func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Save context error: \(error)")
            }
        }
    }
}
