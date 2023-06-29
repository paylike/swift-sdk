import SwiftUI

struct LoadingAnimation: View {
    var color: Color = .blue
    var lineWidth: CGFloat = 2
    var radius: CGFloat = 0.25
    @State var isRotating = 0.0
    
    var body: some View {
        LoadingCircle(radiusRatioToWidth: radius)
            .stroke(color, lineWidth: lineWidth)
            .rotationEffect(.degrees(isRotating))
            .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false)
            )
            .aspectRatio(contentMode: .fit)
            .onAppear {
                isRotating = 720.0
            }
    }
}

struct LoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimation()
    }
}
