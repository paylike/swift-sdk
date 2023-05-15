//
//  CardValidationCodeField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 08..
//

import SwiftUI

struct CardValidationCodeField: View {
    @State private var cvc: String?
    
    let placeholder = "***"
    let label = "CVC"
    
    var body: some View {
        StyledTextField(label, textField:
                            FormattedTextField(placeholder: placeholder, value: $cvc, formatter: CardValidationCodeFormatter()))
        }
}

struct CardValidationCodeField_Previews: PreviewProvider {
    static var previews: some View {
        CardValidationCodeField()
    }
}
