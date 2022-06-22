//
//  ViewModel.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import Combine

protocol ViewModel: ObservableObject {
    var bag: Set<AnyCancellable> { get }
    
    func onAppear()
}
