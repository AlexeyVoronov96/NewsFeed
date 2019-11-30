//
//  ArticlesService.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import CoreData
import Foundation

class ArticlesService {
    private let networkWorker: NetworkWorkerProtocol
    
    init(networkWorker: NetworkWorkerProtocol = NetworkWorker()) {
        self.networkWorker = networkWorker
    }
    
    private var totalResults: Int = 0
    
    func getArticles(from page: Int, completion: @escaping (Error?) -> Void) {
        networkWorker.getData(with: Feed.getArticles(page: page), type: ArticlesResponse.self) { [weak self] (result) in
            switch result {
            case let .success(articlesResponse):
                if page == 1 {
                    do {
                        try CoreDataManager.shared.clearData(in: .article)
                    } catch {
                        completion(error)
                    }
                }
                
                self?.totalResults = articlesResponse.totalResults
                
                self?.save(articles: articlesResponse.articles)
                completion(nil)
                
            case let .failure(error):
                completion(error)
            }
        }
    }
    
    private func save(articles: Articles) {
        for article in articles where filter(by: article.title, description: article.description) {
            ArticleLocal.saveArticle(article)
        }
        CoreDataManager.shared.saveContext()
    }
    
    private func filter(by title: String?, description: String?) -> Bool {
        let request = NSFetchRequest<ArticleLocal>(entityName: "ArticleLocal")
        
        request.predicate = NSPredicate(format: "title = %@ AND subTitle = %@", title ?? "", description ?? "")
        
        do {
            let results = try CoreDataManager.shared.managedObjectContext.fetch(request)
            return results.isEmpty
        } catch {
            return false
        }
    }
}
