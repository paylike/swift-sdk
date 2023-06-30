import SwiftUI

struct ExampleSuccessOverlay: View {
    var showOverlay: Bool
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.white)
                .opacity(0.5)
            Color.accentColor.frame(maxWidth: .infinity, maxHeight: 22)
            Text("Example over, succesful transaction!").font(.headline).foregroundColor(.white)
        }.opacity(showOverlay ? 1.0 : 0.0)
    }
}

struct ExampleSuccessOverlay_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.").padding()
            ExampleSuccessOverlay(showOverlay: true)
        }
    }
}
