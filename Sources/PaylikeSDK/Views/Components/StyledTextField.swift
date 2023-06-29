import SwiftUI

struct StyledTextField<Label>: View where Label : View {
    @EnvironmentObject var theme: Theme
    let label: String
    let textField: TextField<Label>
    let isValid: Bool
    
    public init (_ label: String, textField: TextField<Label>, isValid: Bool = true) {
        self.label = label
        self.textField = textField
        self.isValid = isValid
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(label.uppercased())
                .bold()
            textField.font(.title)
                .foregroundColor(isValid ? theme.primaryColor : theme.errorColor)
                #if os(iOS)
                .keyboardType(.numberPad)
                #endif
        }
    }
}

struct StyledTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack {
                Text("PaylikeTheme")
                StyledTextField("Label", textField: TextField("placeholder", text: .constant("")), isValid: true)
                StyledTextField("Label", textField: TextField("placeholder", text: .constant("lull")), isValid: true)
                StyledTextField("Label", textField: TextField("placeholder", text: .constant("invalid")), isValid: false)
            }
            .environmentObject(PaylikeTheme)
            VStack {
                Text("CustomTheme")
                StyledTextField("Label", textField: TextField("placeholder", text: .constant("")), isValid: true)
                StyledTextField("Label", textField: TextField("placeholder", text: .constant("lull")), isValid: true)
                StyledTextField("Label", textField: TextField("placeholder", text: .constant("invalid")), isValid: false)
            }
            .environmentObject(TestCustomTheme)
        }
    }
}
