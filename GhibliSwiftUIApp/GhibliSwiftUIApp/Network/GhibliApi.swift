import Foundation

enum GhibliApi {
    case films
}

extension GhibliApi {
    private static let baseUrl = "https://ghibliapi.vercel.app/"
    
    var url: String {
        switch self {
        case .films:
            Self.baseUrl + "films"
        }
    }
}
