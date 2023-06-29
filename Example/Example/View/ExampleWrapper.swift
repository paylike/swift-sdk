import SwiftUI

struct ExampleWrapper: View {
    let example: Example
    
    var body: some View {
        VStack {
            Text(example.title)
            Spacer()
            example.exampleView
            Spacer()
        }.padding()
    }
}

struct ExampleWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleWrapper(example: Example(id: "1", title: "Example", details: "Previewing empty example", view: AnyView(EmptyExampleView())))
    }
}
