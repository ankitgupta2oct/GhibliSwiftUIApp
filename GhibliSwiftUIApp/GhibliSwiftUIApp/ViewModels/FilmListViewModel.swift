import Foundation

@Observable
final class FilmListViewModel {
    enum State: Equatable {
        case idle, loading, loaded([Film]), error(String)
    }
    
    var state = State.idle
    @ObservationIgnored private let filmService: FilmService
    
    init(filmService: FilmService = FilmServiceImp()) {
        self.filmService = filmService
    }
    
    func fetch() async {
        guard state == .idle else {
            return
        }
        
        state = .loading
        do {
            let films = try await filmService.fetchFilms()
            state = .loaded(films)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
