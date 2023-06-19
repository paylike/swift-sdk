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
        let formattedField = FormattedTextField(placeholder: placeholder, value: $cardNumber, formatter: CardNumberFormatter())
        GeometryReader { metrics in
            HStack(alignment: .center) {
                StyledTextField(label, textField: formattedField, isValid: isValid)
                CardProviderIcon(cardNumber: cardNumber)
                    .frame(height: metrics.size.height * 0.2)
            }
        }
    }
}

struct CardNumberField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardNumberField(cardNumber: .constant("5105105105105105"), isValid: true) // mastercard
            CardNumberField(cardNumber: .constant("5777777777777777"), isValid: true) // maestro
            CardNumberField(cardNumber: .constant("4111232234334311"), isValid: true) // visa
            CardNumberField(cardNumber: .constant("1234567890123456"), isValid: false) // invalid card number
        }
    }
}
