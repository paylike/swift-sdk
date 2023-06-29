//
//  ErrorLog.swift
//  
//
//  Created by Székely Károly on 2023. 06. 01..
//

import SwiftUI

struct ErrorLog: View {
    @EnvironmentObject var theme: Theme

    var message: String = "Unknown Error"
    
    var body: some View {
        HStack {
            Text(message)
                .foregroundColor(theme.foregroundColor)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(theme.errorColor)
        .cornerRadius(5)
    }
}

struct ErrorLog_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack {
                ErrorLog()
                    .environmentObject(PaylikeTheme)
                ErrorLog()
                    .environmentObject(TestCustomTheme)
            }
            .environment(\.colorScheme, .light)
            VStack {
                ErrorLog()
                    .environmentObject(PaylikeTheme)
                ErrorLog()
                    .environmentObject(TestCustomTheme)
            }
            .environment(\.colorScheme, .dark)
        }
    }
}
