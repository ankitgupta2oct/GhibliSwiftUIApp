import SwiftUI

struct FilmListView: View {
    @Environment(FavoriteManager.self) var favoriteManager
    let films: [Film]
        
    var body: some View {
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
    }
    
    private struct RowView: View {
        let film: Film
        let favoriteManager: FavoriteManager
        
        var body: some View {
            HStack(alignment: .top) {
                ImageView(url: film.image)
                    .frame(width: 100, height: 150)
                VStack(alignment: .leading) {
                    HStack {
                        Text(film.title)
                            .truncationMode(.tail)
                            .lineLimit(1)
                            .bold()
                        Spacer()
                        FavoriteButton(filmId: film.id)
                        .buttonStyle(.plain)
                    }
                    Text("Directed by \(film.director)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("Released: \(film.releaseYear)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .scenePadding(.top)
            }
        }
    }
}

//struct FilmListView: View {
//    @State var viewModel: FilmListViewModel
//    @Environment(FavoriteManager.self) var favoriteManager
//    let contentUnavailableText: String
//        
//    var body: some View {
//        Group {
//            switch viewModel.state {
//            case .idle:
//                ContentUnavailableView(contentUnavailableText, systemImage: "rectangle.and.text.magnifyingglass")
//            case .loading:
//                ProgressView {
//                    Text("Loading...")
//                }
//            case .loaded(let films):
//                List {
//                    ForEach(films) { film in
//                        NavigationLink(value: film) {
//                            RowView(film: film, favoriteManager: favoriteManager)
//                        }
//                    }
//                }
//                .navigationDestination(for: Film.self) { film in
//                    FilmDetailScreen(film: film)
//                }
//            case .error(let message):
//                Text(message)
//            }
//        }
//        .task {
//            await viewModel.fetch()
//        }
//    }
//    
//    private struct RowView: View {
//        let film: Film
//        let favoriteManager: FavoriteManager
//        
//        var body: some View {
//            HStack(alignment: .top) {
//                ImageView(url: film.image)
//                    .frame(width: 100, height: 150)
//                VStack(alignment: .leading) {
//                    HStack {
//                        Text(film.title)
//                            .truncationMode(.tail)
//                            .lineLimit(1)
//                            .bold()
//                        Spacer()
//                        FavoriteButton(filmId: film.id)
//                        .buttonStyle(.plain)
//                    }
//                    Text("Directed by \(film.director)")
//                        .font(.subheadline)
//                        .foregroundStyle(.secondary)
//                    Text("Released: \(film.releaseYear)")
//                        .font(.caption)
//                        .foregroundStyle(.secondary)
//                }
//                .scenePadding(.top)
//            }
//        }
//    }
//}

#Preview {
    @Previewable @State var favoriteManager = FavoriteManager(localStorage: MockLocalStorage())
    
    NavigationStack {
        FilmListView(films: GhibliMocks.instance.films)
            .environment(favoriteManager)
    }
}
