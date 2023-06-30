import Foundation

/// Formatter for card verification code string values, displaying the digits, with a maximum length.
/// Only allows decimal digits, omits everything else from the value.
struct CardVerificationCodeFormatter: TextFieldFormatter {
    typealias Value = String
    
    func displayString(for value: String) -> String {
        return value
    }
    
    func value(from string: String) -> String {
        return String(string.onlyNumbers().prefix(CARD_VERIFICATION_CODE_LENGTH))
    }
}
