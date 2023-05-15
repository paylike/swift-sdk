//
//  CardNumberField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 04..
//

import SwiftUI

struct CardNumberField: View {
    @State private var cardNumber: String?
    
    let placeholder = "0000 0000 0000 0000"
    let label = "Card number"
    
    var body: some View {
            HStack {
                StyledTextField(label, textField:
                                    FormattedTextField(placeholder: placeholder, value: $cardNumber, formatter: CardNumberFormatter()))
                Image("test1234 non existent image")
            }
    }
}

struct CardNumberField_Previews: PreviewProvider {
    static var previews: some View {
        CardNumberField()
    }
}
