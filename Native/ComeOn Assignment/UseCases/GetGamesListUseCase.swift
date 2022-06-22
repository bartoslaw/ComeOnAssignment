//
//  GetGamesListUseCase.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import Combine

protocol GetGamesListUseCaseProtocol: UseCase {
    init(gamesRepository: GamesListRepositoryProtocol)
}

final class GetGamesListUseCase: GetGamesListUseCaseProtocol {
    typealias Result = [Game]
    typealias Params = Void
    
    private let gamesRepository: GamesListRepositoryProtocol
    
    init(gamesRepository: GamesListRepositoryProtocol) {
        self.gamesRepository = gamesRepository
    }
    
    func execute(params: Void?) -> AnyPublisher<Result, Error> {
        return self.gamesRepository
            .getGames()
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
