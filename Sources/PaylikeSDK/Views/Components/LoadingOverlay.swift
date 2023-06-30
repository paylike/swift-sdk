import SwiftUI

struct LoadingOverlay: View {
    @EnvironmentObject var theme: Theme
    
    var lineWidth = 2.0
    
    var backgroundGradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [theme.primaryColor, theme.secondaryColor]), startPoint: .top, endPoint: .bottom)
    }
    var playSuccessAnimation: Bool = false
    var animationProgress: Double {
        return playSuccessAnimation ? 1 : 0.0
    }
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(backgroundGradient)
                    .cornerRadius(15)
                if (playSuccessAnimation) {
                    SuccessAnimation(color: theme.backgroundColor, lineWidth: lineWidth, radius: 0.2, animationProgress: animationProgress)
                } else {
                    LoadingAnimation(color: theme.backgroundColor, lineWidth: lineWidth, radius: 0.2 )
                        .animation(.none)
                }
            }
        }
    }
}

fileprivate struct LandingOverlayPreviewWrapperView: View {
    @State private var startSuccess = false;
    
    var body: some View {
        VStack {
            LoadingOverlay(playSuccessAnimation: startSuccess)
            Toggle("Start Success Animation", isOn: $startSuccess).padding()
        }
    }
}

struct LoadingOverlay_Previews: PreviewProvider {
    static var previews: some View {
        LandingOverlayPreviewWrapperView()
            .environmentObject(PaylikeTheme)
    }
}
