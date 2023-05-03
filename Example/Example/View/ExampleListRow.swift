
import SwiftUI

struct ExampleListRow: View {
    @State private var isActive: Bool = false
    let example: Example
    var body: some View {
        VStack {
            DisclosureGroup{
                VStack(alignment: .center) {
                    Text(example.details).frame(maxWidth:.infinity, alignment: .leading )
                    NavigationLink(isActive: $isActive) {
                        ExampleWrapper(example: example)
                    } label: {
                        EmptyView()
                    }
                    Button {
                        self.isActive = true;
                    } label: {
                        Text("Show Example")
                            .padding(8)
                            .foregroundColor(Color.white)
                            .background(Color.accentColor)
                            .cornerRadius(25)
                    }
                    
                }
            } label: {
                Text(example.title)
            }
        }
    }
}

struct ExampleListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleListRow(example: examples[1])
    }
}
