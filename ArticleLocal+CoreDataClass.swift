//
//  ArticleLocal+CoreDataClass.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ArticleLocal)
public class ArticleLocal: NSManagedObject {
    class func saveArticle(_ article: Article) {
        let localArticle = ArticleLocal(context: CoreDataManager.shared.managedObjectContext)
        
        localArticle.title = article.title
        localArticle.subTitle = article.description
        localArticle.imageLink = article.urlToImage
        localArticle.publishedAt = article.publishedAt
    }
}
