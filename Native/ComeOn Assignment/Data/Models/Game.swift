//
//  Game.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation

struct Game: Codable {
    enum CodingKeys: String, CodingKey {
        case categoryIds
        case code
        case description
        case icon
        case name
        case shortDesc = "short_desc"
        case theme
    }
    
    var categoryIds: [Int]
    var code: String
    var description: String
    var icon: String
    var name: String
    var shortDesc: String
    var theme: String
}
