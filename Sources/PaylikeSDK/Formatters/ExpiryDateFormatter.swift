import Foundation

/// Formatter for card expiration date values, displaying the months and year separated.
/// Only allows decimal digits, omits everything else from the value.
///
/// For example the value: `0126` will display as: `01/26`
struct ExpiryDateFormatter: TextFieldFormatter {
    typealias Value = String
    
    func displayString(for value: String) -> String {
        if (value.count > 2) {
            let dividerIndex = value.index(value.startIndex, offsetBy: 2)
            let month = value[..<dividerIndex]
            let year = value[dividerIndex...]
            return "\(month) / \(year)"
        }
        return value
    }
    
    func value(from string: String) -> String {
        return String(string.onlyNumbers().prefix(4))
    }
}
