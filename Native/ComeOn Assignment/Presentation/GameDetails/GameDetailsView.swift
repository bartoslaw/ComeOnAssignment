//
//  GameDetailsView.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import SwiftUI

struct GameDetailsView: View {
    struct Style {
        static let cardCornerRadius = 8.0
        static let cardShadowOpacity = 0.7
        static let cardShadowRadius = 2.0
        static let cardShadowXOffset = 1.0
        static let cardShadowYOffset = 2.0
        static let cardPadding = 10.0
    }
    
    @StateObject var viewModel: GameDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ZStack {
                    Text(self.viewModel.description)
                        .padding()
                }
                .background(Color.white)
                .cornerRadius(GameDetailsView.Style.cardCornerRadius)
                .shadow(
                    color: Color.black.opacity(GameDetailsView.Style.cardShadowOpacity),
                    radius: GameDetailsView.Style.cardShadowRadius,
                    x: GameDetailsView.Style.cardShadowXOffset,
                    y: GameDetailsView.Style.cardShadowYOffset
                )
                .padding(GameDetailsView.Style.cardPadding)
            }
        }
        .background(Color(UIColor(hex: self.viewModel.themeColorHex) ?? UIColor.black))
        .frame(maxWidth: .infinity)
        .navigationTitle(self.viewModel.title)
        .onAppear {
            self.viewModel.onAppear()
        }
    }
}
