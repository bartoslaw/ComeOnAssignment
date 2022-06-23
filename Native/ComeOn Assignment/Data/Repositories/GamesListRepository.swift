//
//  GamesListRepository.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import Combine

enum GamesListRepositoryError: Error {
    case couldntGetGames(error: Error)
}

protocol GamesListRepositoryProtocol: Repository {
    var path: String { get }
    func getGames() -> AnyPublisher<[Game], Error>
}

final class GamesListRepostiory: GamesListRepositoryProtocol {
    var path: String = "https://kismet-bd1ac.firebaseio.com/assignment/games.json"
    
    private let apiClient: API
    
    init(remoteSource: API) {
        self.apiClient = remoteSource
    }
    
    func getGames() -> AnyPublisher<[Game], Error> {
        let request: AnyPublisher<[Game], Error> = self.apiClient.get(path: self.path, query: nil, body: nil)
        
        return request
            .mapError { error -> GamesListRepositoryError in
                return .couldntGetGames(error: error)
            }
            .eraseToAnyPublisher()
    }
}
