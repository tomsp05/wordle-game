//
//  Wordle_Comp3App.swift
//  Wordle Comp3
//
//  Created by Thomas Speake on 11/01/2023.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore



@main
struct Wordle_Comp3App: App {
    @State var loggedIn = false

    
    let persistenceController = PersistenceController.shared
    @State var selectedTab: Tab? = .home
    @StateObject var model = Model()
    
    init(){
        FirebaseApp.configure()

        let dataBase = Firestore.firestore()
        }
    

    var body: some Scene {
        WindowGroup {
        MainView(selectedTab: $selectedTab)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(Model())
        }
    }
}
