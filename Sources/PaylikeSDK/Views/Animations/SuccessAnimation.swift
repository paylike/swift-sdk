//
//  SuccessAnimiation.swift
//  
//
//  Created by Székely Károly on 2023. 05. 11..
//

import SwiftUI

struct Tick: Shape {
    func path(in rect: CGRect) -> Path {
        let width: CGFloat = rect.width
        let height = width
        
        return Path { path in
            path.move(to: CGPoint(x: width * 0.38, y: height * 0.43 ))
            path.addLine(to: CGPoint(x: width * 0.5, y: height * 0.55))
            path.addLine(to: CGPoint(x: width * 0.8, y: height * 0.25))
        }
    }
}

struct SuccessCircleTransition: Shape {
    var animationProgress: Double = 0.0
    
    var animatableData: Double {
        get { animationProgress }
        set { animationProgress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let width: CGFloat = rect.width
        let height = width
        
        let center = CGPoint(x: width * 0.5, y: height * 0.5 )
        
        let scaleEffect = 0.5 + animationProgress * 0.5;
        
        let radius = width * 0.2 * scaleEffect
        let animatedDegreesOffset = min(100 + 160 * animationProgress, 180)
        return Path { path in
            path.move(to: center.offsetBy(dx: radius, dy: 0))
            path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(animatedDegreesOffset), clockwise: false)
            
            path.move(to: center.offsetBy(dx: 0 - radius, dy: 0))
            path.addArc(center: center, radius: radius, startAngle: .degrees(180), endAngle: .degrees(180 + animatedDegreesOffset), clockwise: false)
        }
    }
}

struct SuccessAnimation: View {
    var color: Color = .blue;
    var lineWidth: CGFloat = 2;
    var animationProgress = 0.0;
    
    var body: some View {
        VStack {
            ZStack {
                Tick()
                    .stroke(color, lineWidth: lineWidth)
                    .offset(x: 0, y: animationProgress > 0 ? 0 : -100)
                    .animation(Animation.easeOut(duration: 0.7), value: animationProgress)
                
                SuccessCircleTransition(animationProgress: animationProgress)
                    .stroke(color, lineWidth: lineWidth)
                    .rotationEffect(.degrees(animationProgress * 90))
                    .animation(Animation.easeInOut(duration: 0.6))
            }
            .frame(width: 300, height: 300)
            
        }
    }
}

private struct WrapperView: View {
    @State private var animationProgress: Double = 0.0
    
    var color: Color = .blue;
    var lineWidth: CGFloat = 2;
    
    var body: some View {
        VStack {
            SuccessAnimation(color: color, lineWidth: lineWidth, animationProgress: animationProgress)
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
        VStack {
            WrapperView(color: .green, lineWidth: 4)
        }
    }
}
