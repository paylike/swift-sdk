//
//  File.swift
//  
//
//  Created by Székely Károly on 2023. 05. 09..
//

import Foundation

struct CardValidationCodeFormatter: TextFieldFormatter {
    typealias Value = String?
    
    func displayString(for value: String?) -> String {
        return value ?? ""
    }
    
    func value(from string: String) -> String? {
        return String(string.onlyNumbers().prefix(3))
    }
}
