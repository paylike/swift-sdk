//
//  ContentView.swift
//
//  Created by Székely Károly on 2023. 04. 26..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ExampleList(examples: getExampleList(engine: getEngine()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
