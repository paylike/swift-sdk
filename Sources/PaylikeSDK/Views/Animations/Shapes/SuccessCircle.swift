import Foundation
import SwiftUI

/// Shape of two arcs forming a circle, drawn inside a square that takes the width of the parent view as its size. Can be animated so the arcs connect up to form a full circle. Has an additional scaling effect on the circle.
struct SuccessCircle: Shape {
    /// The starting radius of the arcs will be multiplied by this amount
    var startingScale = 0.5
    /// The radius of the arcs will be this ratio relative to the width by the end of the animation. e.g.: 0.25 will take 25% of the width
    var finalCircleRadiusRatio = 0.25

    /// Describes how much the two arcs fill the circle. The value should be between 0 and 180 degrees. The animation will animate this value to 180
    var startingArcDegrees = 100.0
    
    /// Progress of the animation, should be a value between 0.0 and 1.0. Set it to 1.0 if you want to play the full animation
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
        let animatedDegreesOffset = min(startingArcDegrees + (180 - startingArcDegrees) * animationProgress, 180)
        return Path { path in
            path.move(to: center.offsetBy(dx: radius, dy: 0))
            path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(animatedDegreesOffset), clockwise: false)
            
            path.move(to: center.offsetBy(dx: 0 - radius, dy: 0))
            path.addArc(center: center, radius: radius, startAngle: .degrees(180), endAngle: .degrees(180 + animatedDegreesOffset), clockwise: false)
        }
    }
}
