//
//  Coordinator.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import Combine

protocol CoordinatorProtocol {
    func makeGamesList()
    func makeGameDetails(game: Game)
}

//final class Coordinator: CoordinatorProtocol {
//    func makeGamesList() {
//        <#code#>
//    }
//    
//    func makeGameDetails(game: Game) {
//        <#code#>
//    }
//    
//    
//}
