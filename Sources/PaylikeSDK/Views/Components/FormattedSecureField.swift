import SwiftUI

public func FormattedSecureField<Formatter: TextFieldFormatter> (placeholder: String, value: Binding<Formatter.Value>, formatter: Formatter) -> SecureField<Text> {
    return SecureField(placeholder, text: Binding(get: {
        return formatter.displayString(for: value.wrappedValue)
    }, set: { string in
        value.wrappedValue = formatter.value(from: string)
    })
    )
}

private struct FormattedSecureFieldPreviewWrapper: View {
    let placeholder: String = "placeholder"
    let formatter = CardValidationCodeFormatter()
    
    @State var value: String = ""

    public var body: some View {
        VStack(alignment: .leading) {
            FormattedSecureField(placeholder: placeholder, value: $value, formatter: formatter)
            Text("Value: \(value)")
        }
    }
}

struct FormattedSecureField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            FormattedSecureFieldPreviewWrapper()
        }
    }
}
