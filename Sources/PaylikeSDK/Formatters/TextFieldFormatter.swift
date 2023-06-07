//
//  TextFieldFormatter.swift
//  
//
//  Created by Székely Károly on 2023. 06. 07..
//

import Foundation

public protocol TextFieldFormatter {
    associatedtype Value
    func displayString(for value: Value) -> String
    func value(from string: String) -> Value
}
