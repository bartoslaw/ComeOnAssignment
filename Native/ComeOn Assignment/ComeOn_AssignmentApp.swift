//
//  ComeOn_AssignmentApp.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import SwiftUI

@main
struct ComeOn_AssignmentApp: App {
    @StateObject var coordinator: Coordinator = Coordinator(injector: Injector())
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().backgroundColor = .blue
    }
    
    var body: some Scene {
        WindowGroup {
            self.coordinator
                .makeGamesList()
                .environmentObject(self.coordinator)
        }
    }
}
