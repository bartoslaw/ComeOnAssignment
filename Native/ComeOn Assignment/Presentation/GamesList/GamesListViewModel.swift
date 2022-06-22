//
//  GamesListViewModel.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import Combine

protocol GamesListVieWModelProtocol: ViewModel {
    init(getGamesListUseCase: GetGamesListUseCase)
}

final class GamesListViewModel: ViewModel {
    var bag: Set<AnyCancellable> = Set()
    var state: ViewModelState = .initial
    
    @Published var totalAmountOfGames: Int = 0
    
    private let getGamesListUseCase: GetGamesListUseCase
    private var games: [Game] = []
    
    init(getGamesListUseCase: GetGamesListUseCase) {
        self.getGamesListUseCase = getGamesListUseCase
    }
    
    func onAppear() {
        self.state = .loading
        
        self.getGamesListUseCase
            .execute(params: nil)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                switch(completion) {
                case .finished:
                    self.state = .finished
                case .failure(let error):
                    print(error)
                    self.state = .error
                }
            } receiveValue: { [weak self] games in
                guard let self = self else { return }
                self.state = .result
                
                self.totalAmountOfGames = games.count
                self.games = games
            }
            .store(in: &bag)
    }
}
