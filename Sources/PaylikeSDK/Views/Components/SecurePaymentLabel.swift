//
//  SecurePaymentLabel.swift
//  
//
//  Created by Székely Károly on 2023. 05. 11..
//

import SwiftUI

struct SecurePaymentLabel: View {
    public var color: Color = Color.green
    
    var body: some View {
        HStack {
            Image(systemName: "leaf")
            Text("Secure payment by Paylike")
        }.foregroundColor(self.color)
    }
}

struct SecurePaymentLabel_Previews: PreviewProvider {
    static var previews: some View {
        SecurePaymentLabel(color: .red)
    }
}
