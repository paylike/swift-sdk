//
//  ExpiryDateField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 04..
//

import SwiftUI

struct ExpiryDateField: View {
    @State private var expiryDate: String?
    
    var body: some View {
        FormattedTextField("00 / 00", label: "Expiry Date", value: $expiryDate, formatter: ExpiryDateFormatter())
    }
}

struct ExpiryDateField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ExpiryDateField()
        }
    }
}
