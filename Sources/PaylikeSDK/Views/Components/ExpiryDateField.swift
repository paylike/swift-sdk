//
//  ExpiryDateField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 04..
//

import SwiftUI

extension NumberFormatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    static let currencyEditing: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ""
        formatter.minimumFractionDigits = NumberFormatter.currency.minimumFractionDigits
        formatter.maximumFractionDigits = NumberFormatter.currency.maximumFractionDigits
        return formatter
    }()
}

struct ExpiryDateField: View {
    @State private var expiryDate: String = ""
    
    var body: some View {
        VStack {
            Text("Expiry Date")
            TextField("title", text: $expiryDate)
        }
    }
}

struct ExpiryDateField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ExpiryDateField()
        }
    }
}
