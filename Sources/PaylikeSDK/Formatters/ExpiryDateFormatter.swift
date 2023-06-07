//
//  ExpiryDateFormatter.swift
//  
//
//  Created by Székely Károly on 2023. 05. 09..
//

import Foundation

struct ExpiryDateFormatter: TextFieldFormatter {
    typealias Value = String
    
    func displayString(for value: String) -> String {
        if (value.count > 2) {
            let dividerIndex = value.index(value.startIndex, offsetBy: 2)
            let month = value[..<dividerIndex]
            let year = value[dividerIndex...]
            return "\(month) / \(year)"
        }
        return value
    }
    
    func value(from string: String) -> String {
        return String(string.onlyNumbers().prefix(4))
    }
}

