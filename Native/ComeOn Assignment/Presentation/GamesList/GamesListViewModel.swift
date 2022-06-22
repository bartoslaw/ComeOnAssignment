//
//  GamesListViewModel.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import Combine

enum GamesListViewModelErrors: Error {
    case incorrectUrl
}

final class GamesListViewModel: ViewModel {
    var bag: Set<AnyCancellable> = Set()
    var state: ViewModelState = .initial
    
    @Published var totalAmountOfGames: Int = 0
    
    private let urlToLoad = "http://localhost:3000"//in real life scenario this will be moved to a separate config file which is connected to proper prod/dev/staging scheme
    private let getGamesListUseCase: GetGamesListUseCase
    private var games: [Game] = []
    
    init(getGamesListUseCase: GetGamesListUseCase) {
        self.getGamesListUseCase = getGamesListUseCase
    }
    
    func getUrlToLoad() -> URL? {
        return URL(string: self.urlToLoad)
    }
    
    func getGame(code: String) -> Game? {
        return self.games.first { $0.code == code }
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
