//
//  FormattedTextField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 05..
//

import SwiftUI

public struct FormattedTextField<Formatter: TextFieldFormatter>: View {
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
        VStack(alignment: .leading) {
            Text(label.uppercased())
                .bold()
            TextField(placeholder, text: Binding(get: {
                return self.formatter.displayString(for: self.value.wrappedValue)
            }, set: { string in
                self.value.wrappedValue = self.formatter.value(from: string)
            })).font(.title)
                .foregroundColor(.green)
        }
    }
}

public protocol TextFieldFormatter {
    associatedtype Value
    func displayString(for value: Value) -> String
    func value(from string: String) -> Value
}

struct FormattedTextField_Previews: PreviewProvider {
    @State static var value: String? = "12345623456"
    static var previews: some View {
        VStack(alignment: .leading) {
            FormattedTextField("placeholder", label: "label", value: $value, formatter: CardNumberFormatter())
            Text("Value: \(value ?? "no value")")
        }
    }
}
