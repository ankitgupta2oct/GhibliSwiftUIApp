import Foundation

protocol FilmService {
    func fetchFilms() async throws -> [Film]
    func search(searchText: String) async throws -> [Film]
}

struct FilmServiceImp: FilmService {
    let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImp()) {
        self.networkService = networkService
    }
    
    func fetchFilms() async throws -> [Film] {
        try await networkService.data(type: [Film].self, GhibliApi.films.url)
    }
    
    func search(searchText: String) async throws -> [Film] {
        do {
            let films = try await fetchFilms()
            return films.filter { $0.title.localizedCaseInsensitiveContains(searchText)}
        } catch {
            return []
        }
    }
}
