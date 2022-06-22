//
//  Coordinator.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import Combine
import SwiftUI

final class Coordinator: ObservableObject {
    private let injector: DependencyInjector
    
    init(injector: DependencyInjector) {
        self.injector = injector
    }
    
    func makeGamesList() -> GamesListView {
        let repository = self.injector.gamesRepository
        let useCase = GetGamesListUseCase(gamesRepository: repository)
        let vm = GamesListViewModel(getGamesListUseCase: useCase)
        
        return GamesListView(viewModel: vm)
    }
    
    func makeGameDetails(game: Game?) -> GameDetailsView {
        let vm = GameDetailsViewModel(game: game)
        return GameDetailsView(viewModel: vm)
    }
}

