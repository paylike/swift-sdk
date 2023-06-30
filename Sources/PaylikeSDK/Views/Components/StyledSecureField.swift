import SwiftUI

struct StyledSecureField<Label>: View where Label: View {
    @EnvironmentObject var theme: Theme
    let label: String
    let secureField: SecureField<Label>
    let isValid: Bool
    
    public init (_ label: String, secureField: SecureField<Label>, isValid: Bool = true) {
        self.label = label
        self.secureField = secureField
        self.isValid = isValid
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Text(label.uppercased())
                .bold()
            secureField.font(.title)
                .foregroundColor(isValid ? theme.primaryColor : theme.errorColor)
            
            #if os(iOS)
            .keyboardType(.numberPad)
            #endif
        }
    }
}

struct StyledSecureField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack {
                StyledSecureField("Secure", secureField: SecureField("placeholder", text: .constant("123")), isValid: true)
            }
            .environmentObject(PaylikeTheme)
            VStack {
                StyledSecureField("Secure", secureField: SecureField("placeholder", text: .constant("123")), isValid: true)
            }
            .environmentObject(TestCustomTheme)
        }
    }
}
