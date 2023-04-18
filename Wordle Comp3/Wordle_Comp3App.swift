//
//  Wordle_Comp3App.swift
//  Wordle Comp3
//
//  Created by Thomas Speake on 11/01/2023.
//

import SwiftUI
import Firebase

@main
struct Wordle_Comp3App: App {
    let persistenceController = PersistenceController.shared
    @State var selectedTab: Tab? = .home
    @StateObject var model = Model()
    
    init(){
        FirebaseApp.configure()
        
    }

    var body: some Scene {
        WindowGroup {
           MainView(selectedTab: $selectedTab)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(Model())
        }
    }
}
