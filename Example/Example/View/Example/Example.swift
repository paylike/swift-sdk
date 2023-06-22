
import Foundation
import SwiftUI
import PaylikeEngine

func getExampleList(engine: PaylikeEngine) -> [Example] {
    let examples: [Example] = [
        Example(id: "1", title: "Paylike Style example", details: "A custom-made widget with Paylike styling boosts customer trust in your application\'s payment flow. This widget has the same capabilities as the Simple White Label form but uses Paylike theme and predefined Paylike style UI elements.", view: AnyView(SimplePaylikeExampleView(engine: engine))),
        Example(id: "2", title: "Example 2", details: "So much to lose", view: AnyView(EmptyExampleView())),
        Example(id: "3", title: "Example 3", details: "Dont be afraid", view: AnyView(EmptyExampleView())),
        Example(id: "4", title: "Example 4", details: "To write a haiku", view: AnyView(EmptyExampleView())),
    ]
    return examples
}


struct Example: Identifiable {
    var id: String
    var title: String
    var details: String
    var exampleView: AnyView
    
    public init (id: String, title: String, details: String, view: AnyView) {
        self.id = id
        self.title = title
        self.details = details
        self.exampleView = view
    }
}
