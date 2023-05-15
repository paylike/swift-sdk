//
//  SuccessAnimiation.swift
//  
//
//  Created by Székely Károly on 2023. 05. 11..
//

import SwiftUI

struct SuccessAnimation: View {
    @State private var animationProgress = 0.0;
    
    var color: Color = .blue;
    var lineWidth: CGFloat = 2;
    
    var body: some View {
        VStack {
            ZStack {
                let width: CGFloat = 300
                let height = width
                Path { path in
                    path.move(to: CGPoint(x: width * 0.38, y: height * 0.43 ))
                    
                    path.addLine(to: CGPoint(x: width * 0.5, y: height * 0.55))
                    path.addLine(to: CGPoint(x: width * 0.8, y: height * 0.25))
                }.stroke(color, lineWidth: lineWidth)
                    .offset(x: 0, y: (animationProgress * 100) - 100)
                Path { path in
                    path.addArc(center: CGPoint(x: width * 0.5, y: height * 0.5 ), radius: width * 0.2, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
                    
                }.stroke(color, lineWidth: lineWidth)
                    .scaleEffect(0.5 + animationProgress * 0.5)
            }.animation(.easeOut(duration: 3), value: animationProgress)
            .frame(width: 300, height: 300)
            
            Slider(value: $animationProgress, in: 0.0...1.0)
                .padding()
        }
    }
}

struct SuccessAnimation_Previews: PreviewProvider {
    static var previews: some View {
        SuccessAnimation()
    }
}
