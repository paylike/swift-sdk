//
//  CardNumberField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 04..
//

import SwiftUI

struct CardNumberFormatter: TextFieldFormatter {
    typealias Value = String?
    
    func displayString(for value: String?) -> String {
        guard let value: String = value else { return "" }
        return value.separateGrouped()
    }
    
    func value(from string: String) -> String? {
        let digits = string
            .components(separatedBy: NSCharacterSet.decimalDigits.inverted)
            .joined()
        return digits
    }
}


struct CardNumberField: View {
    @State private var cardNumber: String?
//    @FocusState private var isCardNumberFocused: Bool = false
    
    var body: some View {
        VStack {
            Text("Card Number")
            HStack {
                FormattedTextField("XXXX XXXX XXXX XXXX", value: $cardNumber, formatter: CardNumberFormatter())
                Image(systemName: "ground")
            }
            Text("Value is \(cardNumber ?? "not defined")")
        }
    }
}

struct CardNumberField_Previews: PreviewProvider {
    static var previews: some View {
        CardNumberField()
    }
}

extension String {
    func separateGrouped(groupSize: Int = 4) -> String {
        var groupedString: String = ""
        stride(from: 0, to: self.count, by: groupSize).forEach {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(self.startIndex, offsetBy: min($0 + groupSize, self.count))
            groupedString += String(self[start..<end])
            if $0+groupSize < self.count {
                groupedString += " "
            }
        }
        return groupedString
    }
}
