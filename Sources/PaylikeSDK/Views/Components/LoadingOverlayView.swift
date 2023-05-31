//
//  LoadingOverlayView.swift
//  
//
//  Created by Székely Károly on 2023. 05. 31..
//

import SwiftUI

struct LoadingOverlayView: View {
    var color = Color.PaylikeGreen
    var lineWidth = 3.0
    
    var body: some View {
        ZStack {
            LoadingAnimation(color: color, lineWidth: lineWidth)
            SuccessAnimation(color: color, lineWidth: lineWidth, animationProgress: 1.0)
        }
    }
}

struct LoadingOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingOverlayView()
    }
}
