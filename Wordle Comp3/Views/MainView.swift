import SwiftUI

struct MainView: View {
#if os(macOS)
    @Binding
    var selectedTab: Tab
#else
    @Binding
    var selectedTab: Tab?
    @State private var dragAmount: CGSize = CGSize.zero
#endif
    @State var showstuff = false
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                HStack(spacing: 0) {
                    NavigationStack {
                        ZStack{
                            selectedTab?.color.opacity(0.05)
                                .ignoresSafeArea()
                            HomeView(color: selectedTab?.color ?? .black)
                        }
                    }
                    
                
                       
                        WordleView(color: selectedTab?.color ?? .black)
                    
                    
                    NavigationStack {
                        ZStack{
                            
                                selectedTab?.color.opacity(0.05)
                                    .ignoresSafeArea()
                            SettingsView(color: selectedTab?.color ?? .black)
                        }
                    }
                }

                .frame(width: proxy.size.width * 3, height: proxy.size.height)
    #if os(macOS)
                    .offset(x: -CGFloat(selectedTab.index) * proxy.size.width)
    #else
                    .offset(x: -CGFloat(selectedTab?.index ?? 0) * proxy.size.width)



    #endif
                    .animation(.easeInOut(duration: 0.25), value: selectedTab)
                    .background(Color("Background"))
            }
            .edgesIgnoringSafeArea(.horizontal)
            
    #if canImport(UIKit)
                .safeAreaInset(edge: .bottom) {
                    TabBar(selectedTab: $selectedTab)
                        .scaleEffect(showstuff ? 1.3 : 1)
                        
                }

    #endif

        }
        .scaleEffect(showstuff ? 0.7 : 1)
            .rotation3DEffect(Angle(degrees: showstuff ? 30 : 0), axis: (x: 0, y: 1, z: 0))
        
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selectedTab: .constant(.home))
            .environmentObject(Model())
    }
}

