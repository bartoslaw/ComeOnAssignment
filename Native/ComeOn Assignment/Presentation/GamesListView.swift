//
//  ContentView.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import SwiftUI

struct GamesListView: View {
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().backgroundColor = .blue
    }
    
    var body: some View {
        NavigationView {
            VStack {
                WebView(url: URL(string: "http://localhost:3000")!)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("list.title")
        }
    }
}

struct GamesListView_Previews: PreviewProvider {
    static var previews: some View {
        GamesListView()
    }
}
