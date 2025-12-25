import Foundation

protocol NetworkService {
    func data<T: Decodable>(type: T.Type, _ url: String) async throws(NetworkError) -> T
}

final class NetworkServiceImp: NetworkService {
    func data<T: Decodable>(type: T.Type, _ url: String) async throws(NetworkError) -> T {
        guard let url = URL(string: url) else {
            throw .invalidUrl(url)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            try Task.checkCancellation()
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            guard (200 ... 299) ~= response.statusCode else {
                throw NetworkError.invalidStatusCode(response.statusCode)
            }
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            try Task.checkCancellation()
            return decodedData
        } catch is CancellationError {
            throw .cancelled
        } catch is DecodingError {
            throw .decodingError
        } catch {
            if let error = error as? NetworkError {
                throw error
            }
            throw .unknown(error)
        }
    }
}
