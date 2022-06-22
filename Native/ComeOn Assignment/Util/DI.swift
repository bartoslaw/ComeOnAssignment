//
//  DI.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation

protocol DependencyInjector { //normally i would use smthg like Swinject, but i want to avoid using 3rd party libs for this assignment
    var api: API { get }
    var gamesRepository: GamesListRepositoryProtocol { get }
}

final class Injector: DependencyInjector {
    lazy var api: API = {
        return APIClient()
    }()
    
    lazy var gamesRepository: GamesListRepositoryProtocol = {
        return GamesListRepostiory(remoteSource: self.api)
    }()
}
