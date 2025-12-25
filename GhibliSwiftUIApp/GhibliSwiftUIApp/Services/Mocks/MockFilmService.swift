import Foundation

struct MockFilmService: FilmService {
    func fetchFilms() async throws -> [Film] {
        GhibliMocks.instance.films
    }
}
