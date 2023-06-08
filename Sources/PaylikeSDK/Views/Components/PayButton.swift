//
//  PayButton.swift
//  
//
//  Created by Székely Károly on 2023. 05. 10..
//

import SwiftUI
import PaylikeClient

public struct PayButtonStyle: ButtonStyle {
    struct StyledButton: View {
            let configuration: ButtonStyle.Configuration
            @Environment(\.isEnabled) private var isEnabled: Bool
            let paylikeButtonGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [Color.PaylikeGreen, Color.PaylikeDarkGreen]), startPoint: .leading, endPoint: .trailing)
            
            var body: some View {
                configuration.label
                        .padding()
                        .foregroundColor(isEnabled ? .white : .gray)
                        .background(
                            paylikeButtonGradient
                        )
                        .opacity(configuration.isPressed ? 0.7 : 1)
                        .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
            }
        }
    
    public func makeBody(configuration: Configuration) -> some View {
        StyledButton(configuration: configuration)
    }
}

struct PayButton: View {
    public init(_ viewModel: PayButtonViewModel) {
        self.viewModel = viewModel
    }
    @ObservedObject var viewModel: PayButtonViewModel
    
    var body: some View {
        Button(action: {
            // async Task is disabled for previews: https://developer.apple.com/forums/thread/704455
            if ProcessInfo
                .processInfo
                .environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
                Task {
                     await viewModel.submit()
                }
            }
        }) {
            HStack {
                Text("Pay")
                Spacer()
                Text(viewModel.displayAmount)
            }
        }
            .buttonStyle(viewModel.styling)
            .disabled(viewModel.disabled)
    }
}

struct PayButton_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            PayButton(
                PayButtonViewModel(amount: PaymentAmount(currency: CurrencyCodes.EUR, value: 3000, exponent: 2))
            )
            PayButton(
                PayButtonViewModel(amount: PaymentAmount(currency: CurrencyCodes.EUR, value: 3000, exponent: 2), disabled: true)
            )
        }
    }
}
