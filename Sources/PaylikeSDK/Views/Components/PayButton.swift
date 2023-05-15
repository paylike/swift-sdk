//
//  PayButton.swift
//  
//
//  Created by Székely Károly on 2023. 05. 10..
//

import SwiftUI

struct PayButtonStyle: ButtonStyle {
    let paylikeButtonGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .leading, endPoint: .trailing)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
                .padding()
                .foregroundColor(.gray)
                .background(
                    paylikeButtonGradient
                )
                .opacity(configuration.isPressed ? 0.7 : 1)
                .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
                .clipShape(RoundedRectangle(cornerRadius: 5))
        
    }
}

struct PayButton<Style: ButtonStyle>: View {
    public init(_ price: String, buttonStyle: Style = PayButtonStyle()) {
        self.price = price
        self.buttonStyle = buttonStyle
    }
    
    public var buttonStyle: Style
    let price: String
    
    public func payAction() {
        // TODO Call pay
    }
    
    var body: some View {
        Button(action: payAction) {
            HStack {
                Text("Pay")
                Spacer()
                Text("\(price)")
            }
        }.buttonStyle(self.buttonStyle)
    }
}

struct PayButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PayButton("29$")
        }
    }
}
