//
//  SuccessCircle.swift
//  
//
//  Created by Székely Károly on 2023. 06. 01..
//

import Foundation
import SwiftUI

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
        
        let radius = width * 0.25 * scaleEffect
        let animatedDegreesOffset = min(100 + 160 * animationProgress, 180)
        return Path { path in
            path.move(to: center.offsetBy(dx: radius, dy: 0))
            path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(animatedDegreesOffset), clockwise: false)
            
            path.move(to: center.offsetBy(dx: 0 - radius, dy: 0))
            path.addArc(center: center, radius: radius, startAngle: .degrees(180), endAngle: .degrees(180 + animatedDegreesOffset), clockwise: false)
        }
    }
}
