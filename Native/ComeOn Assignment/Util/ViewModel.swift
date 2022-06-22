//
//  ViewModel.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import Combine

enum ViewModelState {
    case initial
    case loading
    case result
    case error
    case finished
}

protocol ViewModel: ObservableObject {
    var bag: Set<AnyCancellable> { get }
    var state: ViewModelState { get }
    
    func onAppear()
}
