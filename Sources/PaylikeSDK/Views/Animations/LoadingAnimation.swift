//
//  LoadingAnimation.swift
//  
//
//  Created by Székely Károly on 2023. 05. 12..
//

import SwiftUI

struct LoadingAnimation: View {
    var color: Color = .blue;
    var lineWidth: CGFloat = 2;
    var isRotating: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                let width: CGFloat = 300
                let height = width
                let scale = 0.5
                let radius = width * 0.2 * scale;
                let center = CGPoint(x: width * 0.5, y: height * 0.5 )
                
                Path { path in
                    path.addArc(center: center, radius: radius, startAngle: .degrees(180), endAngle: .degrees(280), clockwise: false)
                    
                    path.move(to: center.offsetBy(dx: radius, dy: 0))
                    
                    path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(100), clockwise: false)
                }.stroke(color, lineWidth: lineWidth)
                    
            }
            .rotationEffect(.degrees(isRotating ? 720 : 0))
            .animation(Animation.easeInOut(duration: 1.5)
                .repeatForever(autoreverses: true))
                .frame(width: 300, height: 300)
        }
    }
}

struct LoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimation()
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
}
