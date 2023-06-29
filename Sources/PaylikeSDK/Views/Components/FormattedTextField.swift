//
//  FormattedTextField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 05..
//

import SwiftUI

public func FormattedTextField<Formatter: TextFieldFormatter> (placeholder: String, value: Binding<Formatter.Value>, formatter: Formatter, onEditingChanged: @escaping (Bool) -> Void = { _ in }) -> TextField<Text> {
    return TextField(placeholder, text: Binding(get: {
        return formatter.displayString(for: value.wrappedValue)
    }, set: { string in
        value.wrappedValue = formatter.value(from: string)
    }), onEditingChanged: onEditingChanged
    )
}

private struct FormattedTextfieldPreviewWrapper: View {
    let placeholder: String = "placeholder"
    let formatter = CardNumberFormatter()

    @State var value: String = ""

    public var body: some View {
        VStack(alignment: .leading) {
            FormattedTextField(placeholder: placeholder, value: $value, formatter: formatter)
            Text("Value: \(value)")
        }
    }
}

struct FormattedTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            FormattedTextfieldPreviewWrapper()
        }
    }
}
