//
//  StyledTextField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 15..
//

import SwiftUI


public struct StyledTextField<Label>: View where Label : View {
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
                .keyboardType(.numberPad)
        }
    }
}

struct StyledTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack {
                StyledTextField("Label", textField: TextField("placeholder", text: .constant("")), isValid: true)
                StyledTextField("Label", textField: TextField("placeholder", text: .constant("lull")), isValid: true)
                StyledTextField("Label", textField: TextField("placeholder", text: .constant("invalid")), isValid: false)
            }
            .environmentObject(PaylikeTheme)
            VStack {
                StyledTextField("Label", textField: TextField("placeholder", text: .constant("")), isValid: true)
                StyledTextField("Label", textField: TextField("placeholder", text: .constant("lull")), isValid: true)
                StyledTextField("Label", textField: TextField("placeholder", text: .constant("invalid")), isValid: false)
            }
            .environmentObject(TestCustomTheme)
        }
    }
}
