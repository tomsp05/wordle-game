import SwiftUI

struct ContentView: View {
    @State var selectedTab = "Home"
    @EnvironmentObject var model: Model
    var color: Color = .black

    var body: some View {
        TabView(selection: $selectedTab) {
                HomeView()
                    .font(.largeTitle)
                    .tabItem { 
                    Text("Home")
                    Image(systemName: "house")
                }.tag("Home")
                
                WordleView()
//            .environmentObject(Model())
                    .font(.largeTitle)
                    .tabItem { 
                    Text("Unlimited Wordle") 
                    Image(systemName: "character.book.closed")
                            
                }.tag("Wordle")
                    
                
                SettingsView()
                    .font(.largeTitle)
                    .tabItem { 
                    Text("Settings") 
                    Image(systemName: "gearshape")
                }.tag("Settings")
                
            }
    }
}
