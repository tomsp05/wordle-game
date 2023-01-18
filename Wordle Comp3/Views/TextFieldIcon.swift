//
//  TextFieldIcon.swift
//  Wordle Comp3
//
//  Created by Thomas Speake on 13/01/2023.
//

import SwiftUI

struct TextFieldIcon: View {
    var iconName: String
    
    @Binding var currentlyEditing: Bool
    @Binding var passedImage: UIImage?
    
    
    var gradient1: [Color] = [
        Color.init(red: 101/255, green: 134/255, blue: 1),
        Color.init(red: 1, green: 64/255, blue: 80/255),
        Color.init(red: 109/255, green: 1, blue: 185/255),
        Color.init(red: 39/255, green: 232/255, blue: 1)
        
        
    ]
    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: .dark)
            ZStack {
                
                if currentlyEditing{
                    AngularGradient(
                        gradient: Gradient(colors: gradient1),
                        center: .center,
                        angle: .degrees(0)
                    )
                    .blur(radius: 10)
                    
                }
                
                Color("tertiaryBackground")
                    .cornerRadius(12)
                    .opacity(0.8)
                .blur(radius: 3.0)
            }
        }
        .cornerRadius(12)
        .overlay(
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white, lineWidth: 1)
                    .blendMode(.overlay)
                if passedImage != nil{
                    Image(uiImage: passedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                            .frame(width: 28, height: 28, alignment: .center)
                            .cornerRadius(8)
                }
                else{
                    Image(systemName: iconName)
                        .foregroundColor(Color("4"))
                        .font(.system(size: 17, weight: .medium))
                }
                
                
                
            }
            )
        .frame(width: 36, height: 36, alignment: .center)
        .padding([.vertical, . leading], 8)
    }
    
}

struct TextFieldIcon_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldIcon(iconName: "key.fill", currentlyEditing: .constant(true), passedImage: .constant(nil))
    }
}
