import SwiftUI

/// Collection of color, and theming values used by views in the SDK. You can use this class, to overwrite the default colors to your own branding
public final class Theme : ObservableObject {
    
    public var providerIconHeight: CGFloat = 20
    public var paylikeIconHeight: CGFloat = 30
    
    public var primaryColor: Color = Color("Paylike Primary Green", bundle: .module)
    public var secondaryColor: Color = Color("Paylike Secondary Green", bundle: .module)
    public var foregroundColor: Color = Color("Foreground", bundle: .module)
    public var backgroundColor: Color = Color("Background", bundle: .module)
    public var errorColor: Color = Color("Error", bundle: .module)
    public var disabledColor: Color = Color("Disabled", bundle: .module)
}

/// A default ``Theme`` using the classic paylike colorset
public let PaylikeTheme = Theme()

/// An example ``Theme`` to showcase usage capabilities
var TestCustomTheme: Theme {
    let theme = Theme()
    theme.primaryColor = .blue
    theme.errorColor = .orange
    theme.disabledColor = Color(red: 1, green: 0.2, blue: 0.2)
    return theme
}
