//
//  MockAPIClient.swift
//  ComeOn AssignmentTests
//
//  Created by Bartłomiej Smektała on 23/06/2022.
//

import Foundation
import Combine
@testable import ComeOn_Assignment

final class MockAPIClient: API {
    var shouldReturnError = false
    
    func get<T>(path: String, query: [String : String]?, body: [String : String]?) -> AnyPublisher<[T], Error> where T : Decodable, T : Encodable {
        if shouldReturnError {
            return Fail(error: APIErrors.requestFailed).eraseToAnyPublisher()
        } else {
            return Just(JSONLoader.loadJson(fileName: "gameslist")!)//fail fast
                .setFailureType(to: Error.self)
                .decode(type: [T].self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
    }
}
