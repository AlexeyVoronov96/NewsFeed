//
//  APIError.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 30.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

struct APIError: Decodable {
    let code: String
    let message: String
}
