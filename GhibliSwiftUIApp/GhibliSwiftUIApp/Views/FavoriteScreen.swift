import SwiftUI

struct FavoriteScreen: View {
    let filmListViewModel: FilmListViewModel
    @Environment(FavoriteManager.self) var favoriteManager
    
    private var favoriteFilms: [Film] {
        if case let .loaded(films) = filmListViewModel.state {
            return films.filter { favoriteManager.favoritesIds.contains($0.id) }
        }
        
        return []
    }
    var body: some View {
        NavigationStack {
            Group {
                if favoriteFilms.isEmpty {
                    ContentUnavailableView("No favorite found", systemImage: "rectangle.and.text.magnifyingglass")
                } else {
                    FilmListView(films: favoriteFilms)
                }
            }
            .navigationTitle("Favorite")
        }
        .task {
            await filmListViewModel.fetch()
        }
    }
}

#Preview {
    @Previewable @State var favoriteManager = FavoriteManager(localStorage: MockLocalStorage())

    FavoriteScreen(filmListViewModel: FilmListViewModel(filmService: MockFilmService()))
        .environment(favoriteManager)
}
