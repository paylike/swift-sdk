//
//  ContentView.swift
//  Example2
//
//  Created by Székely Károly on 2023. 04. 26..
//

import SwiftUI
import PaylikeSDK

struct ContentView: View {
    var body: some View {
        ExampleList()
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
