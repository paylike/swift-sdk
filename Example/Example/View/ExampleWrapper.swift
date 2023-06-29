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
