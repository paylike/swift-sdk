import SwiftUI

/// Creates a TextField that converts its input to a formatted value with a generic type, and displays it as string again.
///
/// - Returns:
///     A TextField with the value formatter configured
func FormattedTextField<Formatter: TextFieldFormatter> (placeholder: String, value: Binding<Formatter.Value>, formatter: Formatter, onEditingChanged: @escaping (Bool) -> Void = { _ in }) -> TextField<Text> {
    return TextField(placeholder, text: Binding(get: {
        return formatter.displayString(for: value.wrappedValue)
    }, set: { string in
        value.wrappedValue = formatter.value(from: string)
    }), onEditingChanged: onEditingChanged
    )
}

fileprivate struct FormattedTextfieldPreviewWrapper: View {
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
