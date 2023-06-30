//
//  TextFieldFormatter.swift
//  
//
//  Created by Székely Károly on 2023. 06. 07..
//

import Foundation

/// Protocol for Formatters for text field values, used by``FormattedTextField(placeholder:value:formatter:onEditingChanged:)``
public protocol TextFieldFormatter {
    /// Wrapped Value of the text field. It can be String, Number, or anything that can be converted from String, and to the displayString using the methods below.
    associatedtype Value
    
    /// Converts the wrapped value of the TextField to its displayed form. When the value changes, displayString will be used to update the displayed value in the TextField
    func displayString(for value: Value) -> String
    
    /// Converts input string to the wrapped value of the TextField.
    func value(from string: String) -> Value
}
