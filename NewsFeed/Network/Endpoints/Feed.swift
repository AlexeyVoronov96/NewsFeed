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
        return ""
    }
    
    var path: String {
        return ""
    }
    
    var params: [String : String] {
        return ["": ""]
    }
    
    var headers: [String : String] {
        return ["": ""]
    }
}
