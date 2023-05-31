//
//  CardNumberField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 04..
//

import SwiftUI

struct CardNumberFieldViewModel {
    
}

struct CardNumberField: View {
    @Binding public var cardNumber: String
    public var isValid: Bool
    
    let placeholder = "0000 0000 0000 0000"
    let label = "Card number"
    
    var body: some View {
            HStack {
                StyledTextField(label, textField:
                                    FormattedTextField(placeholder: placeholder, value: $cardNumber, formatter: CardNumberFormatter()), isValid: isValid)
                Image("mastercard")
            }
    }
}

struct CardNumberField_Previews: PreviewProvider {
    static var previews: some View {
        CardNumberField(cardNumber: .constant("4111232234334311"), isValid: true)
    }
}
