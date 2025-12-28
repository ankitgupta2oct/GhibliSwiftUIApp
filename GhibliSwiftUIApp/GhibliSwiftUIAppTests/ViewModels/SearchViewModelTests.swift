import Foundation
import Testing
@testable import GhibliSwiftUIApp

@MainActor
struct SearchViewModelTests {
    let sut: SearchViewModel
    let mockFilmService: FilmTestingMockService
    
    init() {
        mockFilmService = FilmTestingMockService()
        sut = SearchViewModel(filmService: mockFilmService)
    }
    
    @Test
    func givenEmptySearchText_whenSearch_thenDoNotSearch() async throws {
        sut.searchText = ""
        
        await sut.search()
        
        #expect(mockFilmService.searchCalledCount == 0)
    }
    
    @Test(arguments: ["a", "abc", "film"])
    func givenValidSearchText_whenSearch_thenSearchAndReturnResults(searchText: String) async throws {
        sut.searchText = searchText
        let films = [getFilm()]
        mockFilmService.films = films
        
        await sut.search()
        
        #expect(mockFilmService.searchCalledCount == 1)
        #expect(sut.searchLoadingState == .loaded(films))
    }
}

private extension SearchViewModelTests {
    func getFilm() -> Film {
        Film(id: "1", title: "abc", image: "abc", description: "abc", director: "abc", producer: "abc", people: ["abc"], releaseYear: "2025", score: "9", duration: "120", banner: "abc")
    }
}
