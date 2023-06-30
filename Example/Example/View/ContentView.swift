import SwiftUI
import PaylikeSDK

struct ContentView: View {
    var body: some View {
        ExampleList(examples: getExampleList())
            .environmentObject(PaylikeTheme)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .light)
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
