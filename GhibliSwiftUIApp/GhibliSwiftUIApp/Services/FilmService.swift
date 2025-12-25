import Foundation

protocol FilmService {
    func fetchFilms() async throws -> [Film]
}

struct FilmServiceImp: FilmService {
    let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImp()) {
        self.networkService = networkService
    }
    
    func fetchFilms() async throws -> [Film] {
        try await networkService.data(type: [Film].self, GhibliApi.films.url)
    }
}
