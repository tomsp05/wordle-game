//
//  Wordle_Comp3App.swift
//  Wordle Comp3
//
//  Created by Thomas Speake on 11/01/2023.
//

import SwiftUI

@main
struct Wordle_Comp3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
