//
//  ArticleLocal+CoreDataProperties.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//
//

import Foundation
import CoreData


extension ArticleLocal {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleLocal> {
        return NSFetchRequest<ArticleLocal>(entityName: "ArticleLocal")
    }

    @NSManaged public var title: String?
    @NSManaged public var subTitle: String?
    @NSManaged public var imageLink: String?
    @NSManaged public var publishedAt: Date?
}
