import SwiftUI

/// Branding component meant to grow customer trust
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
