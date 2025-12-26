import SwiftUI

struct FilmListView: View {
    @State var viewModel: FilmListViewModel
    @Environment(FavoriteManager.self) var favoriteManager
    let contentUnavailableText: String
        
    var body: some View {
        Group {
            switch viewModel.state {
            case .idle:
                ContentUnavailableView(contentUnavailableText, systemImage: "rectangle.and.text.magnifyingglass")
            case .loading:
                ProgressView {
                    Text("Loading...")
                }
            case .loaded(let films):
                List {
                    ForEach(films) { film in
                        NavigationLink(value: film) {
                            RowView(film: film, favoriteManager: favoriteManager)
                        }
                    }
                }
                .navigationDestination(for: Film.self) { film in
                    FilmDetailScreen(film: film)
                }
            case .error(let message):
                Text(message)
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
    
    private struct RowView: View {
        let film: Film
        let favoriteManager: FavoriteManager
        
        private var isFavorite: Bool {
            favoriteManager.isFavorite(for: film.id)
        }
        
        var body: some View {
            HStack {
                ImageView(url: film.image)
                    .frame(width: 100, height: 150)
                Text(film.title)
                Button {
                    favoriteManager.toggleFavorite(for: film.id)
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(isFavorite ? .red : .primary)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    @Previewable @State var favoriteManager = FavoriteManager(localStorage: MockLocalStorage())
    
    NavigationStack {
        FilmListView(viewModel: FilmListViewModel(filmService: MockFilmService()), contentUnavailableText: "No data")
            .environment(favoriteManager)
    }
}
