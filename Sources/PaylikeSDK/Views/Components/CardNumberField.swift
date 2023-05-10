//
//  CardNumberField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 04..
//

import SwiftUI

struct CardNumberField: View {
    @State private var cardNumber: String?
    
    var body: some View {
            HStack {
                FormattedTextField("0000 0000 0000 0000", label: "Card number", value: $cardNumber, formatter: CardNumberFormatter())
                Image("visa")
            }
    }
}

struct CardNumberField_Previews: PreviewProvider {
    static var previews: some View {
        CardNumberField()
    }
}
