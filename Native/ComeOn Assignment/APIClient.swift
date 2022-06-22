//
//  APIClient.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import Combine

import Combine

enum APIErrors: Error {
    case wrongUrl
    case requestFailed
}

protocol API {
    func get<T: Codable>(path: String, query: [String: String]?, body: [String: String]?) -> AnyPublisher<T, Error>
}

final class APIClient: API {
    func get<T: Codable>(path: String, query: [String: String]?, body: [String: String]?) -> AnyPublisher<T, Error> {
        guard
            var urlComponents = URLComponents(string: baseUrl)
        else {
            return Fail(error: APIErrors.wrongUrl).eraseToAnyPublisher()
        }
        
        urlComponents.queryItems = query.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        urlComponents.bo
        
        let urlRequest = URLRequest(url: urlComponents.url!)
        
        return URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { response in
                guard
                    let httpResponse = response.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                else {
                    throw APIErrors.requestFailed
                }

                return response.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
