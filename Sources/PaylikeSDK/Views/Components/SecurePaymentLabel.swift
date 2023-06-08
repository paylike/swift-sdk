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
            Image("paylike-logo", bundle: .module)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 30)

            Text("Secure payment by Paylike")
        }.foregroundColor(self.color)
    }
}

struct SecurePaymentLabel_Previews: PreviewProvider {
    static var previews: some View {
        SecurePaymentLabel(color: .PaylikeGreen)
    }
}
