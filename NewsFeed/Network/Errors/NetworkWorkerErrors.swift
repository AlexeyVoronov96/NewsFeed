//
//  NetworkWorkerErrors.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

enum NetworkWorkerErrors: LocalizedError {
    case wrongRequest
    case wrongResponse
    case dataNil
    case fetchingError
    case apiError(error: String)
    
    var errorDescription: String? {
        switch self {
        case let .apiError(error):
            return error
            
        default:
            return "Something goes wrong..."
        }
    }
}
