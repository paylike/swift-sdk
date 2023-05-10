//
//  ExampleWrapperView.swift
//  Example2
//
//  Created by Székely Károly on 2023. 04. 26..
//

import SwiftUI

struct ExampleWrapper: View {
    let example: Example
    var body: some View {
        VStack {
            Text(example.title)
        }
    }
}

struct ExampleWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleWrapper(example: examples[0])
    }
}
