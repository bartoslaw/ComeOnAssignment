//
//  APIClient.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import Combine

enum APIErrors: Error {
    case wrongUrl
    case requestFailed
}

protocol API {
    func get<T: Codable>(path: String, query: [String: String]?, body: [String: String]?) -> AnyPublisher<[T], Error>
}

final class APIClient: API {
    func get<T: Codable>(path: String, query: [String: String]?, body: [String: String]?) -> AnyPublisher<[T], Error> {
        guard
            var urlComponents = URLComponents(string: path)
        else {
            return Fail(error: APIErrors.wrongUrl).eraseToAnyPublisher()
        }
        
        if let query = query {
            urlComponents.queryItems = query.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        
        if let body = body {
            do  {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            } catch(let error) {
                print(error) //TODO: add proper error handling
            }
        }
        
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
            .decode(type: [T].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
