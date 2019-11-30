//
//  ResponseStatus.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

enum ResponseStatus: String, Decodable {
    case ok
    case error
}
