import SwiftUI
import PaylikeClient

struct PayButtonStyle: ButtonStyle {
    struct StyledButton: View {
        let configuration: ButtonStyle.Configuration
        @EnvironmentObject var theme: Theme
        @Environment(\.isEnabled) private var isEnabled: Bool
        var paylikeButtonGradient: LinearGradient {
            LinearGradient(gradient: Gradient(colors: [theme.primaryColor, theme.secondaryColor]), startPoint: .leading, endPoint: .trailing)
        }
        
        var body: some View {
            configuration.label
                .padding()
                .foregroundColor(isEnabled ? theme.foregroundColor : theme.disabledColor)
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
    var displayAmount: String
    var submit: () async -> Void
    var disabled: Bool
    var styling: PayButtonStyle = PayButtonStyle()
    
    var body: some View {
        Button(action: {
            // async Task is disabled for previews: https://developer.apple.com/forums/thread/704455
            if ProcessInfo
                .processInfo
                .environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
                Task {
                    await submit()
                }
            }
        }) {
            HStack {
                Text("Pay")
                Spacer()
                Text(displayAmount)
            }
        }
        .buttonStyle(styling)
        .disabled(disabled)
    }
}

struct PayButton_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            VStack {
                PayButton(displayAmount: "90.00 EUR", submit: {}, disabled: false)
                PayButton(displayAmount: "60.00 EUR", submit: {}, disabled: true)
                PayButton(displayAmount: "60.00 EUR", submit: {}, disabled: false)
            }
            .environment(\.colorScheme, .light)
            VStack {
                PayButton(displayAmount: "90.00 EUR", submit: {}, disabled: false)
                PayButton(displayAmount: "60.00 EUR", submit: {}, disabled: true)
                PayButton(displayAmount: "60.00 EUR", submit: {}, disabled: false)
            }
            .environment(\.colorScheme, .dark)
        }
        .environmentObject(PaylikeTheme)
    }
}
