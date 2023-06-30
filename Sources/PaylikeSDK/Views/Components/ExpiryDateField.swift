import SwiftUI

struct ExpiryDateField: View {
    @Binding public var expiryDate: String
    public var isValid: Bool
    @State public var isEditing: Bool = false
    
    let placeholder = "00 / 00"
    let label = "Expiry Month/Year"
    var body: some View {
        let formattedField = FormattedTextField(placeholder: placeholder, value: $expiryDate, formatter: ExpiryDateFormatter(), onEditingChanged: { isEditing in
            self.isEditing = isEditing
        })
        StyledTextField(label, textField: formattedField, isValid: isValid || isEditing)
    }
}

struct ExpiryDateField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ExpiryDateField(expiryDate: .constant("0123"), isValid: true)
            ExpiryDateField(expiryDate: .constant("013"), isValid: false)
        }
        .environmentObject(PaylikeTheme)
    }
}
