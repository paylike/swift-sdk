
import SwiftUI

struct ExampleList: View {
    var body: some View {
        NavigationView {
            VStack {
                ForEach(examples) { example in
                    ExampleListRow(example: example)
                    Divider()
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Examples")
        }
    }
}

struct ExampleListView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleList()
    }
}
