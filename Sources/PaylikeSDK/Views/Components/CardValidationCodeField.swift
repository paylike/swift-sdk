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
        let formattedField = FormattedSecureField(placeholder: placeholder, value: $cvc, formatter: CardValidationCodeFormatter())
        StyledSecureField(label, secureField: formattedField, isValid: isValid)
    }
}

struct CardValidationCodeField_Previews: PreviewProvider {
    static var previews: some View {
        CardValidationCodeField(cvc: .constant("321"), isValid: true)
        CardValidationCodeField(cvc: .constant("1"), isValid: true)
    }
}
