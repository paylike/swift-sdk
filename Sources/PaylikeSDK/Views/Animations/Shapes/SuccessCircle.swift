//
//  SuccessCircle.swift
//  
//
//  Created by Székely Károly on 2023. 06. 01..
//

import Foundation
import SwiftUI

struct SuccessCircle: Shape {
    var startingScale = 0.5
    var finalCircleRadiusRatio = 0.25
    var startingArcDegrees = 100.0
    var animatedArcDegrees = 160.0
    
    var animationProgress: Double = 0.0
    
    var animatableData: Double {
        get { animationProgress }
        set { animationProgress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let width: CGFloat = rect.width
        let height = width
        
        let center = CGPoint(x: 0.5, y: 0.5 ).multiplyBy(mx: width, my: height)
        
        let scaleEffect = startingScale + animationProgress * (1 - startingScale);
        
        let radius = width * finalCircleRadiusRatio * scaleEffect
        let animatedDegreesOffset = min(startingArcDegrees + animatedArcDegrees * animationProgress, 180)
        return Path { path in
            path.move(to: center.offsetBy(dx: radius, dy: 0))
            path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(animatedDegreesOffset), clockwise: false)
            
            path.move(to: center.offsetBy(dx: 0 - radius, dy: 0))
            path.addArc(center: center, radius: radius, startAngle: .degrees(180), endAngle: .degrees(180 + animatedDegreesOffset), clockwise: false)
        }
    }
}
