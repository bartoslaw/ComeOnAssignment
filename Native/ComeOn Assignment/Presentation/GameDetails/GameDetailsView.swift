//
//  GameDetailsView.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import SwiftUI

struct GameDetailsView: View {
    @StateObject var viewModel: GameDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ZStack {
                    Text(self.viewModel.description)
                        .padding()
                }
                .background(Color.white)
                .cornerRadius(8.0)
                .shadow(color: Color.black.opacity(0.7), radius: 2.0, x: 1.0, y: 2.0)
                .padding(10.0)
            }
        }
        .background(Color(UIColor(rgb: self.viewModel.themeColorHex)))
        .frame(maxWidth: .infinity)
        .navigationTitle(self.viewModel.title)
        .onAppear {
            self.viewModel.onAppear()
        }
    }
}
