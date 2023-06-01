//
//  ErrorLog.swift
//  
//
//  Created by Székely Károly on 2023. 06. 01..
//

import SwiftUI

struct ErrorLog: View {
    var message: String = "Unknown Error"
    
    var body: some View {
        HStack {
            Text(message)
                .foregroundColor(.white)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.PaylikeError)
        .cornerRadius(5)
    }
}

struct ErrorLog_Previews: PreviewProvider {
    static var previews: some View {
        ErrorLog()
    }
}
