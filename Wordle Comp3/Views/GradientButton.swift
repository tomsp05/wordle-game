//
//  GradientButton.swift
//  Wordle Comp3
//
//  Created by Thomas Speake on 13/01/2023.
//

import SwiftUI

struct GradientButton2: View {
    
    var gradient1: [Color] = [
        Color.red,
        Color.orange,
        Color.red,
        Color.orange
        
        
    ]
    
    var body: some View {
        Button(action: {
            print("sign up")
        }, label: {
            GeometryReader() { geometry in
                ZStack{
                    AngularGradient(gradient:
                                        Gradient(colors: gradient1), center: .center,angle: .degrees(0))
                    .blendMode(.overlay)
                    .blur(radius: 8.0)
                    .mask(
                        RoundedRectangle(cornerRadius: 16.0)
                            .frame(height: 50)
                            .frame (maxWidth: geometry.size.width - 16)
                            .blur(radius: 8.0)
                    )
                    Text("Sign Up")
                        .foregroundColor(Color("4"))
                        .font(.headline)
                        .frame(width: geometry.size.width - 16)
                        .frame(height: 50)
                        .background(
                            Color("tertiaryBackground")
                                .opacity(0.9)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 1.9)
                                .blendMode(.normal)
                                .opacity(0.7)
                        )
                        .cornerRadius(16.0)
                    
                }
            }
            .frame(height: 50.0)
        })
    }
    
}
