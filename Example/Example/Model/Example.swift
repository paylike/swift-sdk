
import Foundation

let examples: [Example] = [
    Example(id: "1", title: "Example 1", details: "So much to say"),
    Example(id: "2", title: "Example 2", details: "So much to lose"),
    Example(id: "3", title: "Example 3", details: "Dont be afraid"),
    Example(id: "4", title: "Example 4", details: "To write a haiku"),
]

struct Example: Identifiable {
    var id: String
    var title: String
    var details: String
}
