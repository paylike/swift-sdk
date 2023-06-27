//
//  CardValidationCodeField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 08..
//

import SwiftUI

struct CardValidationCodeField: View {
    @Binding public var cvc: String
    public var isValid: Bool
    @State public var isEditing: Bool = false
    
    let placeholder = "***"
    let label = "CVC"
    
    var body: some View {
        let formattedField = FormattedTextField(placeholder: placeholder, value: $cvc, formatter: CardValidationCodeFormatter(), onEditingChanged: { isEditing in
            self.isEditing = isEditing
        })
        StyledTextField(label, textField: formattedField, isValid: isValid || isEditing)
    }
}

struct CardValidationCodeField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardValidationCodeField(cvc: .constant("321"), isValid: true)
            CardValidationCodeField(cvc: .constant("31"), isValid: true)
            CardValidationCodeField(cvc: .constant("1"), isValid: true)
        }
        .environmentObject(PaylikeTheme)
    }
}
