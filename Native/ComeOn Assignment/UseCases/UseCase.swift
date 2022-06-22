//
//  UseCase.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import Combine

protocol UseCase {
    associatedtype Result: Codable
    associatedtype Params: Codable
    
    func execute(params: Params) -> AnyPublisher<Result, Error>
}
