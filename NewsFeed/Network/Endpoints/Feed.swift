//
//  Feed.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

enum Feed: EndpointProtocol {
    case getArticles(page: Int)

    var host: String {
        return "newsapi.org"
    }
    
    var path: String {
        return "/v2/everything"
    }
    
    var params: [String : String] {
        switch self {
        case let .getArticles(page):
            return [
                "page": "\(page)",
                "q": "Apple",
                "sortBy": "publishedAt",
                "language": "en"
            ]
        }
    }
    
    var headers: [String : String] {
        return ["X-Api-Key": Settings.apiKey]
    }
}
