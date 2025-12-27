import SwiftUI

struct MovieScreen: View {
    let filmListViewModel: FilmListViewModel
    var body: some View {
        NavigationStack {
            Group {
                switch filmListViewModel.state {
                case .idle:
                    ContentUnavailableView("No movies found", systemImage: "rectangle.and.text.magnifyingglass")
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                case .loaded(let films):
                    FilmListView(films: films)
                case .error(let message):
                    Text(message)
                }
            }
            .navigationTitle("Movies")
        }
        .task {
            await filmListViewModel.fetch()
        }
    }
}

#Preview {
    MovieScreen(filmListViewModel: FilmListViewModel(filmService: MockFilmService()))
}
