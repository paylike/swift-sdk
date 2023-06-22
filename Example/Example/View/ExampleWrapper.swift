//
//  ExampleWrapperView.swift
//
//  Created by Székely Károly on 2023. 04. 26..
//

import SwiftUI
import PaylikeSDK
import PaylikeEngine
import PaylikeClient

struct ExampleWrapper: View {
    let example: Example
    
    var body: some View {
        VStack {
            Text(example.title)
            
            example.exampleView
        }
    }
}

struct ExampleWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleWrapper(example: Example(id: "2", title: "Example 2", details: "So much to lose", view: AnyView(EmptyExampleView())))
    }
}
