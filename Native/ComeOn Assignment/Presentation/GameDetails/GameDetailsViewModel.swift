//
//  GameDetailsViewModel.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import Combine

final class GameDetailsViewModel: ViewModel {
    var bag: Set<AnyCancellable> = Set()
    var state: ViewModelState = .initial
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var themeColorHex: UInt = 0
    
    private let game: Game?
    
    init(game: Game?) {
        self.game = game
    }
    
    func onAppear() {
        if let game = game {
            self.title = game.name
            self.description = game.description
            self.themeColorHex = self.parseRGBString(rgbString: game.theme)
            
            self.state = .finished
        } else {
            self.state = .error
        }
    }
    
    private func parseRGBString(rgbString: String) -> UInt {
        var str = rgbString.replacingOccurrences(of: "RGB(", with: "").dropLast()
        
        if str.count == 6 {
            str = "FF" + str
        }
        
        print(str)
        
        return UInt(str)!
    }
}
