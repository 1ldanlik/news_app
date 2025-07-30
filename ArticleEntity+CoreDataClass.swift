//
//  ArticleEntity+CoreDataClass.swift
//  news_app
//
//  Created by Ildan on 14.07.2025.
//
//

import Foundation
import CoreData

@objc(ArticleEntity)
public class ArticleEntity: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.articleId = UUID()
    }
}
