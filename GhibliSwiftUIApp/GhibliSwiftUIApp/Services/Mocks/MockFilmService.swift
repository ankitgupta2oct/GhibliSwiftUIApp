import Foundation

struct MockFilmService: FilmService {
    func fetchFilms() async throws -> [Film] {
        GhibliMocks.instance.films
    }
    
    func search(searchText: String) async throws -> [Film] {
        GhibliMocks.instance.films.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
}
