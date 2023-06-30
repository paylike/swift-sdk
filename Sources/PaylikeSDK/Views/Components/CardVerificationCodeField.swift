import SwiftUI

/// Formatted Card Verification Code which wraps a SecureField underneath. It is styled according to the ``Theme`` defined in the environment
struct CardVerificationCodeField: View {
    @Binding public var cvc: String
    public var isValid: Bool
    
    let placeholder = "***"
    let label = "CVC"
    
    var body: some View {
        let formattedField = FormattedSecureField(placeholder: placeholder, value: $cvc, formatter: CardVerificationCodeFormatter()
        )
        StyledSecureField(label, secureField: formattedField, isValid: isValid)

    }
}

struct CardValidationCodeField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardVerificationCodeField(cvc: .constant("321"), isValid: true)
            CardVerificationCodeField(cvc: .constant("31"), isValid: true)
            CardVerificationCodeField(cvc: .constant("1"), isValid: true)
            CardVerificationCodeField(cvc: .constant(""), isValid: true)
        }
        .environmentObject(PaylikeTheme)
    }
}
