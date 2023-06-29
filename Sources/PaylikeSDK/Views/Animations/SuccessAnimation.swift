//
//  SuccessAnimiation.swift
//  
//
//  Created by Székely Károly on 2023. 05. 11..
//

import SwiftUI

struct SuccessAnimation: View {
    var color: Color = .blue
    var lineWidth: CGFloat = 2
    var duration = 0.6
    var radius: CGFloat = 0.2
    
    @State var animationProgress = 0.0
    

    var body: some View {
            ZStack {
                Tick(shortSideLength: radius - 0.05, longSideLength: radius + 0.1)
                    .stroke(color, lineWidth: lineWidth)
                    .offset(x: 0, y: animationProgress > 0 ? 0 : -100)
                    .animation(Animation.easeOut(duration: 0.7), value: animationProgress)
                    .opacity(min(animationProgress * 20, 1))
                    .animation(Animation.linear(duration: duration/2), value: animationProgress)
                
                SuccessCircle(startingScale: radius / (radius + 0.05), finalCircleRadiusRatio: radius + 0.05, animationProgress: animationProgress)
                    .stroke(color, lineWidth: lineWidth)
                    .animation( Animation.easeInOut(duration: duration), value: animationProgress
                    )
            }.aspectRatio(contentMode: .fit)
    }
}

private struct SuccessAnimationPreviewWrapper: View {
    @State private var animationProgress: Double = 0.0
    
    var color: Color = .blue;
    var lineWidth: CGFloat = 2;
    
    var body: some View {
        VStack {
            SuccessAnimation(color: color, lineWidth: lineWidth, animationProgress: animationProgress)
                .aspectRatio(1, contentMode: .fit)
            Button("Trigger") {
                self.animationProgress = animationProgress < 1 ? 1.0 : 0.0;
            }
            Slider(value: $animationProgress, in: 0.0...1.0)
                .padding()
        }
    }
}

struct SuccessAnimation_Previews: PreviewProvider {
    static var previews: some View {
        SuccessAnimationPreviewWrapper(color: .green, lineWidth: 4)
    }
}
