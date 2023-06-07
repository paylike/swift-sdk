//
//  StyledTextField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 15..
//

import SwiftUI


public struct StyledTextField<Label>: View where Label : View {
    public init (_ label: String, textField: TextField<Label>, isValid: Bool = true) {
        self.label = label
        self.textField = textField
        self.isValid = isValid
    }
    let label: String
    let textField: TextField<Label>
    // TODO only show validation error, if the field was already touched
    let isValid: Bool
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(label.uppercased())
                .bold()
            textField.font(.title)
                .foregroundColor(isValid ? Color.PaylikeGreen : Color.PaylikeError)
        }
    }
}

struct StyledTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StyledTextField("Label", textField: TextField("placeholder", text: .constant("")), isValid: true)
            StyledTextField("Label", textField: TextField("placeholder", text: .constant("lull")), isValid: true)
            StyledTextField("Label", textField: TextField("placeholder", text: .constant("invalid")), isValid: false)
        }
    }
}
