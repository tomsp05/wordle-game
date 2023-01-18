import SwiftUI

struct GradientText: View {
    var text: String = "Text here"

    var body: some View {
        Text(text)
            .gradientForeground(colors: [Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)), Color(#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1))])

    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}


struct GradientText_Previews: PreviewProvider {
    static var previews: some View {
        GradientText()
    }
}
