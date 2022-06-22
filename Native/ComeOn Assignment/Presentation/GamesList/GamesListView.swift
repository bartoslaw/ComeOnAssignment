//
//  ContentView.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import SwiftUI
import Combine

struct GamesListView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: GamesListViewModel
    
    @State var showDetails = false
    @State var currentCode = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    WebView(url: self.viewModel.getUrlToLoad()) { code in
                        self.currentCode = code
                        self.showDetails.toggle()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("list.title")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Text(String(format: NSLocalizedString("list.number.of.games %d", comment: ""),
                                    self.viewModel.totalAmountOfGames))
                            .font(.system(size: 11.0))
                            .foregroundColor(.white)
                    }
                }
                
                if self.viewModel.state == .loading {
                    ProgressView()
                        .frame(width: 100.0, height: 100.0)
                }
                
                NavigationLink(isActive: $showDetails) {
                    self.coordinator.makeGameDetails(game: self.viewModel.getGame(code: self.currentCode))
                } label: {
                    EmptyView()//normally i would use something like stinsen for coordination instead of nav links, but i want to avoid using external libraries for this assignment
                }
            }
        }
        .onAppear {
            self.viewModel.onAppear()
        }
    }
}
