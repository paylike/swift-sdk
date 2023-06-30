import SwiftUI


import Foundation
import SwiftUI

/// Shape of two arcs forming a circle, drawn inside a square that takes the width of the parent view as its size.
struct LoadingCircle: Shape {
    /// The circle radius ratio to the width of the shape: e.g.: 0.25 will take 25% of the width
    var radiusRatioToWidth = 0.25
    /// Describes how much the two arcs fill the circle. The value should be between 0 and 180 degrees.
    var startingArcDegrees = 100.0
    
    func path(in rect: CGRect) -> Path {
        let width: CGFloat = rect.width
        let height = width
        
        let center = CGPoint(x: 0.5, y: 0.5 ).multiplyBy(mx: width, my: height)
        let radius = width * radiusRatioToWidth

        return Path { path in
            path.move(to: center.offsetBy(dx: radius, dy: 0))
            path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(startingArcDegrees), clockwise: false)
            
            path.move(to: center.offsetBy(dx: 0 - radius, dy: 0))
            path.addArc(center: center, radius: radius, startAngle: .degrees(180), endAngle: .degrees(180 + startingArcDegrees), clockwise: false)
        }
    }
}
