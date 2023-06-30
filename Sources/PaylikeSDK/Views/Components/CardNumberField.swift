import SwiftUI

/// Formatted Card Number Field which wraps a TextField underneath. It is styled according to the ``Theme`` defined in the environment
struct CardNumberField: View {
    @EnvironmentObject var theme: Theme
    @Binding public var cardNumber: String
    public var isValid: Bool
    @State public var isEditing: Bool = false
    
    /// Placeholder for the internal text field
    let placeholder = "0000 0000 0000 0000"
    /// Label associated with the text field
    let label = "Card number"
    
    var body: some View {
        let formattedField = FormattedTextField(placeholder: placeholder, value: $cardNumber, formatter: CardNumberFormatter(), onEditingChanged: { isEditing in
            self.isEditing = isEditing
        })
        HStack(alignment: .center) {
            StyledTextField(label, textField: formattedField, isValid: isValid || isEditing)
            CardProviderIcon(cardNumber: cardNumber, height: theme.providerIconHeight)
        }
    }
}

struct CardNumberField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack {
                CardNumberField(cardNumber: .constant("5105105105105105"), isValid: true)// mastercard
                CardNumberField(cardNumber: .constant("5777777777777777"), isValid: true) // maestro
                CardNumberField(cardNumber: .constant("4111232234334311"), isValid: true) // visa
                CardNumberField(cardNumber: .constant("1234567890123456"), isValid: false) // invalid card number
            }
            .environmentObject(PaylikeTheme)
            VStack {
                CardNumberField(cardNumber: .constant("5105105105105105"), isValid: true)// mastercard
                CardNumberField(cardNumber: .constant("5777777777777777"), isValid: true) // maestro
                CardNumberField(cardNumber: .constant("4111232234334311"), isValid: true) // visa
                CardNumberField(cardNumber: .constant("1234567890123456"), isValid: false) // invalid card number
            }
            .environmentObject(TestCustomTheme)
        }
    }
}
