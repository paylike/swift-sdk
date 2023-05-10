//
//  CardValidationCodeField.swift
//  
//
//  Created by Székely Károly on 2023. 05. 08..
//

import SwiftUI

struct CardValidationCodeField: View {
    @State private var cvc: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                FormattedTextField("***", label: "CVC", value: $cvc, formatter: CardValidationCodeFormatter())
            }
        }
    }
}

struct CardValidationCodeField_Previews: PreviewProvider {
    static var previews: some View {
        CardValidationCodeField()
    }
}
