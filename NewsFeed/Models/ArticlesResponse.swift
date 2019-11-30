//
//  ArticlesResponse.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

struct ArticlesResponse: Decodable {
    let status: ResponseStatus
    let totalResults: Int

    let articles: Articles
}
