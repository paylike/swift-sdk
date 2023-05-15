//
//  ExpiryDateField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 04..
//

import SwiftUI

struct ExpiryDateField: View {
    @State private var expiryDate: String?
    
    let placeholder = "00 / 00"
    let label = "Expiry Month/Year"
    var body: some View {
        StyledTextField(label, textField:
                            FormattedTextField(placeholder: placeholder, value: $expiryDate, formatter: ExpiryDateFormatter()))
    }
}

struct ExpiryDateField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ExpiryDateField()
        }
    }
}
