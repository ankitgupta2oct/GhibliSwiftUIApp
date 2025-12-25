import Foundation

enum NetworkError: Error {
    case invalidUrl(String)
    case invalidResponse
    case invalidStatusCode(Int)
    case decodingError
    case unknown(Error)
    case cancelled
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl(_):
            "Invalid Url"
        case .invalidResponse:
            "Invalid Response"
        case .invalidStatusCode(let code):
            "Invalid Status Code \(code)"
        case .decodingError:
            "Decoding Error"
        case .unknown(_):
            "Unkown Error"
        case .cancelled:
            "Task Cancelled"
        }
    }
}
