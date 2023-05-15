//
//  FormattedTextFieldView.swift
//  
//
//  Created by Székely Károly on 2023. 05. 05..
//

import SwiftUI

public protocol TextFieldFormatter {
    associatedtype Value
    func displayString(for value: Value) -> String
    func value(from string: String) -> Value
}

public func FormattedTextField<Formatter: TextFieldFormatter> (placeholder: String, value: Binding<Formatter.Value>, formatter: Formatter) -> TextField<Text> {
    return TextField(placeholder, text: Binding(get: {
        return formatter.displayString(for: value.wrappedValue)
    }, set: { string in
        value.wrappedValue = formatter.value(from: string)
    }))
}

private struct FormattedTextFieldView<Formatter: TextFieldFormatter>: View {
    public init(_ placeholder: String,
                label: String,
                value: Binding<Formatter.Value>,
                formatter: Formatter) {
        self.placeholder = placeholder
        self.value = value
        self.formatter = formatter
        self.label = label
    }

    let label: String
    let placeholder: String
    let value: Binding<Formatter.Value>
    let formatter: Formatter

    public var body: some View {
        StyledTextField(label, textField: FormattedTextField(placeholder: placeholder, value: value, formatter: formatter))
    }
}

struct FormattedTextField_Previews: PreviewProvider {
    static var value: String = "12345623456"
    static var previews: some View {
        VStack(alignment: .leading) {
            FormattedTextFieldView("placeholder", label: "label", value: .constant(value), formatter: CardNumberFormatter())
            Text("Value: \(value)")
        }
    }
}
