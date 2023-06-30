import Foundation
import PaylikeClient
import PaylikeRequest

class MockClient: Client {
    
    var clientID: String = "Mocked"
    
    var httpClient: HTTPClient = MockHTTPClient()
    
    var loggingFn: (Encodable) -> Void = { _ in }
    
    init() {}

    func tokenize(applePayData data: TokenizeApplePayDataRequest, withCompletion handler: @escaping (Result<ApplePayToken, Error>) -> Void) {}
    
    func tokenize(cardData data: TokenizeCardDataRequest, withCompletion handler: @escaping (Result<CardDataToken, Error>) -> Void) {}
    
    func tokenize(applePayData data: TokenizeApplePayDataRequest) async throws -> ApplePayToken {
        throw ClientError.UnknownError
    }
    
    func tokenize(cardData data: TokenizeCardDataRequest) async throws -> CardDataToken {
        throw ClientError.UnknownError
    }
    
    func createPayment(with requestData: CreatePaymentRequest, withCompletion handler: @escaping (Result<PaylikeClientResponse, Error>) -> Void) {}
    
    func createPayment(with requestData: CreatePaymentRequest) async throws -> PaylikeClientResponse {
        throw ClientError.UnknownError
    }
}

class MockHTTPClient: HTTPClient {
    var loggingFn: (Encodable) -> Void = { _ in }
    
    init() {}
    
    func sendRequest(to endpoint: URL, withOptions options: RequestOptions) async throws -> PaylikeResponse {
        throw HTTPClientError.UnknownError
    }
    
    func sendRequest(to endpoint: URL, withOptions options: RequestOptions, completion handler: @escaping (Result<PaylikeResponse, Error>) -> Void) {}
}
