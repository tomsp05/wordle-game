//
//  GradientTextField.swift
//  Wordle Comp3
//
//  Created by Thomas Speake on 15/01/2023.
//

import SwiftUI

struct GradientTextField: View {
    
    @Binding var editingTextField: Bool
    @Binding var textFieldString: String
    @Binding var iconBounce: Bool
    
    var textFieldPlaceholder: String
    var textFieldIconString: String
    private let generator = UISelectionFeedbackGenerator()
    
    var body: some View {
        HStack(spacing: 12.0){
            TextFieldIcon(iconName: textFieldIconString, currentlyEditing: $editingTextField, passedImage: .constant(nil))
            TextField(textFieldPlaceholder, text: $textFieldString){
                isEditing in
                editingTextField = isEditing
            }
            .colorScheme(.dark)
            .foregroundColor(Color.white.opacity(0.7))
        }
        .overlay(RoundedRectangle(cornerRadius: 16)
            .stroke(Color.white, lineWidth: 1)
            .blendMode(.overlay)
        )
        .background(
            Color("secondaryBackground"))
        .cornerRadius(16)
    }
}

struct GradientTextField_Previews: PreviewProvider {
    static var previews: some View {
        GradientTextField(editingTextField: .constant(true), textFieldString: .constant("Some string here"), iconBounce: .constant(false), textFieldPlaceholder: "Test textfield", textFieldIconString: "textformat.alt")
    }
}
