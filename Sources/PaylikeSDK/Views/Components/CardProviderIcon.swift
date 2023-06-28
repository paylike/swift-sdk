//
//  CardProviderIcon.swift
//  
//
//  Created by Laszlo Kocsis on 2023. 06. 12..
//

import Foundation
import SwiftUI

struct CardProviderIcon: View {
    public let cardNumber: String
    public let height: CGFloat
    
    var body: some View {
        if let cardType = calculateCardProviderFromNumber(number: cardNumber)?.rawValue {
            Image(cardType, bundle: .module)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: height)
        } else {
            EmptyView()
        }
    }
}

fileprivate enum SupportedCardProviders: String {
    case mastercard
    case maestro
    case visa
}

fileprivate func calculateCardProviderFromNumber(number: String) -> SupportedCardProviders? {
    let regexes: Dictionary<SupportedCardProviders, NSRegularExpression> = [
        .mastercard: try! NSRegularExpression(pattern: "^(5[1-5]|222[1-9]|22[3-9]|2[3-6]|27[01]|2720)[0-9]*$", options: []),
        .maestro: try! NSRegularExpression(pattern: "^5[06789|6][0-9]*$", options: []),
        .visa: try! NSRegularExpression(pattern: "^4[0-9]*$", options: []),
    ]
    var result: SupportedCardProviders?
    regexes.forEach { entry in
        if !entry.value.matches(in: number, range: NSRange(location: 0, length: number.utf16.count)).isEmpty {
            result = entry.key
        }
    }
    return result
}

struct CardProviderIconPreviewWrapperView: View {
    @State var height: CGFloat = 20
    
    var body: some View {
        VStack(alignment: .center) {
            CardProviderIcon(cardNumber: "5105105105105105", height: height) // mastercard
            Divider()
            CardProviderIcon(cardNumber: "4111232234334311", height: height) // visa
            Divider()
            CardProviderIcon(cardNumber: "1234567890123456", height: height) // invalid
            Text("EmptyView in case of invalid card number")
            Divider()
            CardProviderIcon(cardNumber: "5777777777777777", height: height) // maestro
            Spacer()
            VStack {
                Text("Icon height: \(height, specifier: "%.2f")")
                Slider(value: $height, in: .init(uncheckedBounds: (lower: 0, upper: 200)))
            }
            .frame(width: 300)
        }
    }
}

struct CardProviderIcon_Previews: PreviewProvider {
    static var previews: some View {
        CardProviderIconPreviewWrapperView()
            .environmentObject(PaylikeTheme)
    }
}
