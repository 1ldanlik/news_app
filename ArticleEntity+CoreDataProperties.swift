//
//  ArticleEntity+CoreDataProperties.swift
//  news_app
//
//  Created by Ildan on 14.07.2025.
//
//

import Foundation
import CoreData


extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }

    @NSManaged public var author: String?
    @NSManaged public var desc: String?
    @NSManaged public var articleId: UUID?
    @NSManaged public var publishedAt: String?
    @NSManaged public var sourceId: String?
    @NSManaged public var sourceName: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var content: String?

}

extension ArticleEntity : Identifiable {

}
