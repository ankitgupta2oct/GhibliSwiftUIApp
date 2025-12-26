import Foundation

@Observable
final class SearchViewModel {
    var searchText = ""
    var searchLoadingState: ContentLoadingState<[Film]> = .idle
    @ObservationIgnored private let filmService: FilmService
    
    init(filmService: FilmService = FilmServiceImp()) {
        self.filmService = filmService
    }
    
    func search() async {
        guard !searchText.isEmpty else {
            searchLoadingState = .idle
            return
        }
        
        searchLoadingState = .loading
        do {
            let films = try await filmService.search(searchText: searchText)
            searchLoadingState = .loaded(films)
        } catch {
            print(error.localizedDescription)
            searchLoadingState = .error(error.localizedDescription)
        }
    }
}
