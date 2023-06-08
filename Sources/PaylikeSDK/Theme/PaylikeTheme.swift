//
//  PaylikeTheme.swift
//  
//
//  Created by Székely Károly on 2023. 05. 10..
//

import Foundation
import SwiftUI

extension Color {
    static var PaylikeGreen: Color {
        return Color("Paylike Green", bundle: .module)
    }
    
    static var PaylikeError: Color {
        return Color(red: 0.8, green: 0.2, blue: 0.2)
    }
    
    static var PaylikeLightGreen: Color {
        return Color("Paylike Light Green", bundle: .module)
    }
    
    static var PaylikeDarkGreen: Color {
        return Color(red: 0, green: 0.376, blue: 0) //Color("Paylike Dark Green")
    }
}
