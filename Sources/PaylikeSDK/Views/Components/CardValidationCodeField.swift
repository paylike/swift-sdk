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
    
    let placeholder = "***"
    let label = "CVC"
    
    var body: some View {
        StyledTextField(label, textField:
                            FormattedTextField(placeholder: placeholder, value: $cvc, formatter: CardValidationCodeFormatter()), isValid: isValid)
        }
}

struct CardValidationCodeField_Previews: PreviewProvider {
    static var previews: some View {
        CardValidationCodeField(cvc: .constant("321"), isValid: true)
    }
}
