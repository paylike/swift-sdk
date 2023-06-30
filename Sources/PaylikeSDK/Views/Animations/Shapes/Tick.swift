import SwiftUI
import Foundation

/// Shape of a tick or checkmark for the sucecss animation, drawn inside a square that takes the width of the parent view. The short and long side of the tick, and a vertical offset from the center can be configured
struct Tick: Shape {
    /// Short side of the tick relative to the full width
    var shortSideLength = 0.15
    /// Long side of the tick relative to the full width
    var longSideLength = 0.3
    /// Vertical offset of the center of the tick relative to full height.
    var centerOffset = 0.1
    
    func path(in rect: CGRect) -> Path {
        let width: CGFloat = rect.width
        let height = width
        let center = CGPoint(x:0.5, y: 0.5)
        
        
        let basePoint = center.offsetBy(dx: 0.0, dy: centerOffset)
        let shortSidePoint = basePoint.offsetBy(dx: -shortSideLength, dy: -shortSideLength)
        let longSidePoint = basePoint.offsetBy(dx: longSideLength, dy: -longSideLength)
        
        return Path { path in
            path.move(to: shortSidePoint.multiplyBy(mx: width, my: height))
            path.addLine(to: basePoint.multiplyBy(mx: width, my: height))
            path.addLine(to: longSidePoint.multiplyBy(mx: width, my: height))
        }
    }
}

extension CGPoint {
    /// Retuns the point which is an offset of an existing point.
    ///
    /// - Parameters:
    ///   - dx: The x-coordinate offset to apply.
    ///   - dy: The y-coordinate offset to apply.
    ///
    /// - Returns:
    ///   A new point which is an offset of an existing point.
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
      return CGPoint(x: x + dx, y: y + dy)
    }
    
    /// Retuns the point which is a multiplication of an exsiting point along both axes
    ///
    /// - Parameters:
    ///   - mx: The x-coordinate multiplication to apply.
    ///   - my: The y-coordinate multiplication to apply.
    ///
    /// - Returns:
    ///   A new point which is a multiplication of an existing point.
    func multiplyBy(mx: CGFloat, my: CGFloat) -> CGPoint {
    return CGPoint(x: x * mx, y: y * my)
    }
}
