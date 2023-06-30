import Foundation

/// Formatter for card number string values, displaying the digits grouped into fours.
/// Only allows decimal digits, omits everything else from the value.
///
/// For example the value: `4111111111111111` will display as: `4111 1111 1111 1111`
struct CardNumberFormatter: TextFieldFormatter {
    typealias Value = String
    
    func displayString(for value: String) -> String {
        return value.separateGrouped()
    }
    
    func value(from string: String) -> String {
        return String(string.onlyNumbers()
            .prefix(CARD_NUMBER_MAX_LENGTH))
    }
}

extension String {
    /// Retuns a new string which is separated into groups depending on the group size
    ///
    /// - Parameters:
    ///   - groupSize: the number of characters that should be separated.
    ///   - separator: the string that separtes the groups.
    ///
    /// - Returns:
    ///   New string with the gorups separated
    func separateGrouped(groupSize: Int = 4, separator: String = " ") -> String {
        var groupedString: String = ""
        stride(from: 0, to: self.count, by: groupSize).forEach {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(self.startIndex, offsetBy: min($0 + groupSize, self.count))
            groupedString += String(self[start..<end])
            if $0+groupSize < self.count {
                groupedString += separator
            }
        }
        return groupedString
    }

    /// Filters decimal digit characters from a string
    ///
    /// For example `asdf1234asdf` will become `1234`
    ///
    /// - Returns:
    ///   New string only containing decimal digits
    func onlyNumbers() -> String {
        let digits = self
            .components(separatedBy: NSCharacterSet.decimalDigits.inverted)
            .joined()
        return digits
    }
}
