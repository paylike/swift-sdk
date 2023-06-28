//
//  AdditionalTextField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 15..
//

import SwiftUI

struct AdditionalTextField: View {
    let label: String
    let placeholder: String
    let value: Binding<String>
    
    var body: some View {
        StyledTextField(label, textField: TextField(placeholder, text: value), isValid: true)
    }
}

struct AdditionalTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AdditionalTextField(label: "Empty", placeholder: "be free here", value: .constant(""))
            AdditionalTextField(label: "Texts", placeholder: "be free here", value: .constant("written text"))
        }
        .previewLayout(.fixed(width: 300, height: 70))
        .environmentObject(PaylikeTheme)
    }
}
