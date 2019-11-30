//
//  NetworkWorkerProtocol.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

protocol NetworkWorkerProtocol {
    func getData<T: Decodable>(with endpoint: EndpointProtocol, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}
