//
//  LoadingOverlay.swift
//  
//
//  Created by Székely Károly on 2023. 05. 31..
//

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
                SuccessAnimation(color: theme.foregroundColor, lineWidth: lineWidth, animationProgress: animationProgress)
                    .aspectRatio(1, contentMode: ContentMode.fit)
            }
        }
    }
}

private struct LandingOverlayPreviewWrapperView: View {
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
