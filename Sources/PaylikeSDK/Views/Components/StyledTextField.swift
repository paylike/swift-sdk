//
//  StyledTextField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 15..
//

import SwiftUI


public struct StyledTextField<Label>: View where Label : View {
    public init (_ label: String, textField: TextField<Label>) {
        self.label = label
        self.textField = textField
    }
    let label: String
    let textField: TextField<Label>
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(label.uppercased())
                .bold()
            textField.font(.title)
                .foregroundColor(.green)
        }
    }
}

struct StyledTextField_Previews: PreviewProvider {
    static var previews: some View {
        StyledTextField("Label", textField: TextField("placeholder", text: .constant("lull")))
    }
}
