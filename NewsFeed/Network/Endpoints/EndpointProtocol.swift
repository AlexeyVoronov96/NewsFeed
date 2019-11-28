//
//  EndpointProtocol.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

protocol EndpointProtocol {
    var host: String { get }

    var path: String { get }

    var params: [String: String] { get }

    var headers: [String: String] { get }
}
