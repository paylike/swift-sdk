//
//  SecurePaymentLabel.swift
//  
//
//  Created by Székely Károly on 2023. 05. 11..
//

import SwiftUI

struct SecurePaymentLabel: View {
    @EnvironmentObject var theme: Theme
    
    var body: some View {
        HStack {
            Image("paylike-logo", bundle: .module)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: theme.paylikeIconHeight)

            Text("Secure payment by Paylike")
        }.foregroundColor(theme.primaryColor)
    }
}

struct SecurePaymentLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SecurePaymentLabel()
                .environmentObject(PaylikeTheme)
            SecurePaymentLabel()
                .environmentObject(TestCustomTheme)
        }
    }
}
