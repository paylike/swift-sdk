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

public protocol Validator {
    func validate(for value: String) -> Bool
}

public class AnyValidator {
    func validate(for value: String) -> Bool {
        return true
    }
}

public func FormattedTextField<Formatter: TextFieldFormatter> (placeholder: String, value: Binding<Formatter.Value>, formatter: Formatter) -> TextField<Text> {
    return TextField(placeholder, text: Binding(get: {
        return formatter.displayString(for: value.wrappedValue)
    }, set: { string in
        value.wrappedValue = formatter.value(from: string)
    }))
}

private struct FormattedTextFieldView<Formatter: TextFieldFormatter>: View {
    @State public var value: Formatter.Value
    
    public init(_ placeholder: String,
                label: String,
                formatter: Formatter) {
        self.placeholder = placeholder
        self.formatter = formatter
        self.label = label
        _value = State(initialValue: formatter.value(from: ""))
    }

    let label: String
    let placeholder: String
    let formatter: Formatter
//    let validator: AnyValidator<Formatter.Value> = AnyValidator<Formatter.Value>()

    public var body: some View {
        VStack {
            StyledTextField(label, textField: FormattedTextField(placeholder: placeholder, value: $value, formatter: formatter), isValid: true)
        }
    }
}

struct FormattedTextField_Previews: PreviewProvider {
    static var value: String = "12345623456"
    static var previews: some View {
        VStack(alignment: .leading) {
            FormattedTextFieldView("placeholder", label: "label", formatter: CardNumberFormatter())
            Text("Value: \(value)")
        }
    }
}
