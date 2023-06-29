//
//  SwiftUIView.swift
//  
//
//  Created by Károly Székely on 2023. 06. 29..
//

import SwiftUI


import Foundation
import SwiftUI

struct LoadingCircle: Shape {
    var radiusRatioToWidth = 0.25
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
