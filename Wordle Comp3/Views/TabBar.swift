import SwiftUI
import UIKit


#if canImport(UIKit)
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
#endif

struct TabBar: View {
    @Binding
    var selectedTab: Tab?
    @State var tabItemWidth: CGFloat = 0
    @State var color: Color = Color("1")

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        GeometryReader { proxy in

            let hasHomeIndicator = proxy.safeAreaInsets.bottom > 0

            HStack {

                buttons            }
            .padding(.bottom, hasHomeIndicator ? 35 : 23)
                        .padding(.horizontal, 8)
                        .padding(.top, hasHomeIndicator ? 16 : 20)
                        .frame(maxWidth: .infinity, maxHeight: hasHomeIndicator ? 98 : 79)
                        .background(.ultraThinMaterial)
                        .cornerRadius(34, corners: [.topLeft, .topRight])
                                   
                                    .overlay(
                                        RoundedCorner(radius: 35, corners: [.topLeft, .topRight])
                                            .stroke(
                                                colorScheme == .dark ? .white.opacity(0.5)
                            : .black.opacity(0.1)
                                            )
                                            .blendMode(colorScheme == .dark ? .overlay : .normal)

                                    )
                                    .frame(maxHeight: .infinity, alignment: .bottom)
                                    .ignoresSafeArea()
        .animation(.easeInOut, value: selectedTab )
        }
    }

    var buttons: some View{
        ForEach(tabItems) { item in
                VStack(spacing: 0) {
                    ZStack {
                        Image(systemName: item.icon)
                            .foregroundColor(selectedTab == item.tab ? color : .gray.opacity(0.7))
                            .font(.system(size: 22))



                    }
                    .frame(width: 31, height: 31)
                    .padding(.bottom, 1.5)

                        Text(item.text)
                            .font(.caption2)
                            .lineLimit(1)
                            .foregroundColor(selectedTab == item.tab ? color : .gray.opacity(0.7))




                }
                .frame(maxWidth: .infinity)


            .onTapGesture {
                withAnimation(.easeInOut) {
                    let impact = UIImpactFeedbackGenerator(style: .light)
                          impact.impactOccurred()
                    selectedTab = item.tab
                    color = item.color
                    
                }
            }



        }
    }
    }
