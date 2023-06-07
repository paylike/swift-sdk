//
//  CardNumberFormatter.swift
//  
//
//  Created by Székely Károly on 2023. 05. 09..
//

import Foundation

struct CardNumberFormatter: TextFieldFormatter {
    typealias Value = String
    
    func displayString(for value: String) -> String {
        return value.separateGrouped()
    }
    
    func value(from string: String) -> String {
        return String(string.onlyNumbers()
            .prefix(CARD_NUMBER_MAX_LENGTH))
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
    
    func onlyNumbers() -> String {
        let digits = self
            .components(separatedBy: NSCharacterSet.decimalDigits.inverted)
            .joined()
        return digits
    }
}
