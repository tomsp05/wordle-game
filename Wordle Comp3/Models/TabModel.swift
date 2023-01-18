import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var index: Int
    var color: Color = Color("AccentColor")
}

var tabItems = [
    TabItem(text: "Home", icon: "house.fill", tab: .home, index: 0, color: Color("1")),
    TabItem(text: "Game", icon: "character.book.closed.fill", tab: .wordle, index: 1, color: Color("2")),
    TabItem(text: "Settings", icon: "gearshape.fill", tab: .settings, index: 2, color: Color("4"))
]

enum Tab: String {
    case home
    case wordle
    case settings

    public var index: Int {
        switch self {
        case .home:
            return 0
        case .wordle:
            return 1
        case .settings:
            return 2
        }
    }
    
    public var color: Color {
        switch self{
        case .home :
            return Color("1")
        case .wordle :
            return Color("2")
        case .settings :
            return Color("4")
        }
    }
}
