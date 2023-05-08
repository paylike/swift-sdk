//
//  FormattedTextField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 05..
//

import SwiftUI

public struct FormattedTextField<Formatter: TextFieldFormatter>: View {
    public init(_ title: String,
                value: Binding<Formatter.Value>,
                formatter: Formatter) {
        self.title = title
        self.value = value
        self.formatter = formatter
    }

    let title: String
    let value: Binding<Formatter.Value>
    let formatter: Formatter

    public var body: some View {
        TextField(title, text: Binding(get: {
            return self.formatter.displayString(for: self.value.wrappedValue)
        }, set: { string in
            self.value.wrappedValue = self.formatter.value(from: string)
        }))
    }
}

public protocol TextFieldFormatter {
    associatedtype Value
    func displayString(for value: Value) -> String
    func value(from string: String) -> Value
}
