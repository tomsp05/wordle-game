import SwiftUI
import Combine

class Model: ObservableObject {
    @Published var numGuesses: Int = 0

    @AppStorage("fontSize") var fontSize: Double = 24
    @AppStorage("loggedIn") var loggedIn: Bool = false



}
