import Foundation
@testable import GhibliSwiftUIApp

final class FilmTestingMockService: FilmService {
    var fetchCalledCount = 0
    var searchCalledCount = 0
    var error: Error?
    var films: [Film]?
    
    func fetchFilms() async throws -> [Film] {
        fetchCalledCount += 1
        return films ?? []
    }
    
    func search(searchText: String) async throws -> [Film] {
        searchCalledCount += 1
        if let error {
            throw error
        }
        
        return films ?? []
    }
}
