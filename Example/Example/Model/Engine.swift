/// API key, may modified in your local machine to run tests with Paylike API
let merchantId = "YOUR_KEY"

import Foundation
import PaylikeEngine

func getEngine() -> PaylikeEngine {
    // Create a new PaylikeEngine instance. You can switch the loggingMode to .DEBUG to get a verbose console output
    return PaylikeEngine(merchantID: merchantId, engineMode: .TEST, loggingMode: .RELEASE)
}
