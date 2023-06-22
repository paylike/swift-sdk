/*
* API key, may modified in your local machine to run tests with Paylike API
*/
let merchantId = "YOUR_KEY"

import Foundation
import PaylikeEngine

func getEngine() -> PaylikeEngine {
    return PaylikeEngine(merchantID: merchantId, engineMode: .TEST, loggingMode: .DEBUG)
}
