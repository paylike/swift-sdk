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
    var animationProgress = 0.0
    @State var isRotating = 0.0
    
    var body: some View {
            ZStack {
                Tick()
                    .stroke(color, lineWidth: lineWidth)
                    .offset(x: 0, y: animationProgress > 0 ? 0 : -100)
                    .animation(Animation.easeOut(duration: 0.7), value: animationProgress)
                    .opacity(min(animationProgress * 20, 1))
                    .animation(Animation.linear(duration: 0.3), value: animationProgress)
                
                SuccessCircle(animationProgress: animationProgress)
                    .stroke(color, lineWidth: lineWidth)
                    .rotationEffect(.degrees(isRotating))
                    .animation(animationProgress == 0.0 ?
                               Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false) :
                                Animation.easeInOut(duration: 0.6), value: [ animationProgress, isRotating ]
                    )
                    .onAppear(perform: {
                        isRotating = 720.0
                    })
            }
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
