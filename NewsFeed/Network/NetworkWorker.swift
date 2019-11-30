//
//  NetworkWorker.swift
//  NewsFeed
//
//  Created by Алексей Воронов on 28.11.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import Foundation

class NetworkWorker: NetworkWorkerProtocol {
    private let jsonDecoder: JSONDecoder
    private let session: URLSession

    init(jsonDecoder: JSONDecoder = JSONDecoder(),
         session: URLSession = URLSession.shared) {
        self.jsonDecoder = jsonDecoder
        self.session = session
    }

    func getData<T: Decodable>(with endpoint: EndpointProtocol, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = performRequest(with: endpoint) else {
            completion(Result.failure(NetworkWorkerErrors.wrongRequest))
            return
        }

        loadData(with: request, type: type, completion: completion)
    }

    private func performRequest(with endpoint: EndpointProtocol) -> URLRequest? {
        var components = URLComponents()

        components.scheme = "https"
        components.host = endpoint.host
        components.path = endpoint.path
        components.queryItems = endpoint.params.map({ (param) -> URLQueryItem in
            return URLQueryItem(name: param.key, value: param.value)
        })
        
        guard let url = components.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        for header in endpoint.headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }

        return urlRequest
    }
    
    private func loadData<T: Decodable>(with request: URLRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                completion(Result.failure(error))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(NetworkWorkerErrors.dataNil))
                return
            }
            
            guard let parsedData = self?.parse(data, with: type) else {
                completion(Result.failure(NetworkWorkerErrors.fetchingError))
                return
            }
            
            completion(Result.success(parsedData))
        }.resume()
    }
    
    private func parse<T: Decodable>(_ data: Data, with type: T.Type) -> T? {
        do {
            jsonDecoder.dateDecodingStrategy = .iso8601
            return try jsonDecoder.decode(type, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
