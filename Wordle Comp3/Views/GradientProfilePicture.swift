import SwiftUI

struct GradientProfilePicture: View {
    var profilePicture: UIImage
    var gradient1: [Color] = [
        Color.red,
        Color.orange,
        Color.red,
        Color.orange
    ]

    @State private var angle: Double = 0

    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: gradient1), center: .center, angle: .degrees(angle))
                .mask(
                    Circle()
                        .frame(width: 70, height: 70, alignment: .center)
                        .blur(radius: 8.0)
                )
                .blur(radius: 8.0)
                .onAppear {
                    withAnimation(.linear(duration: 7)) {
                        self.angle += 350
                    }
                }
            Image(uiImage: profilePicture)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 66, height: 66, alignment: .center)
                .mask(
                    Circle()
            )
        }

    }
}

struct GradientProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                GradientProfilePicture(profilePicture: UIImage(named: "Profile")!)
                Spacer()
            }
            Spacer()
        }
        .background(Color.black)
            
    }
}
