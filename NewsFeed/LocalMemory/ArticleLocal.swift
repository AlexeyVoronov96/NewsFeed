//
//  ArticleLocal+CoreDataClass.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//
//

import CoreData
import Foundation

public class ArticleLocal: NSManagedObject {
    // MARK: - Properties
    @NSManaged public var title: String?
    @NSManaged public var subTitle: String?
    @NSManaged public var imageLink: String?
    @NSManaged public var articleLink: String?
    @NSManaged public var publishedAt: Date?
    
    // MARK: - Methods
    static func saveArticle(_ article: Article) {
        let localArticle = ArticleLocal(context: CoreDataManager.shared.managedObjectContext)
        
        localArticle.title = article.title
        localArticle.subTitle = article.description
        localArticle.imageLink = article.urlToImage
        localArticle.articleLink = article.url
        localArticle.publishedAt = article.publishedAt
    }
}
