import SwiftUI

struct FilmListView: View {
    @State var viewModel: FilmListViewModel
    
    init(viewModel: FilmListViewModel = FilmListViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .idle:
                ContentUnavailableView("No films found", systemImage: "rectangle.and.text.magnifyingglass")
            case .loading:
                ProgressView {
                    Text("Loading...")
                }
            case .loaded(let films):
                List {
                    ForEach(films) { film in
                        NavigationLink(value: film) {
                            HStack {
                                ImageView(url: film.image)
                                    .frame(width: 100, height: 150)
                                Text(film.title)
                            }
                        }
                    }
                }
                .navigationDestination(for: Film.self) { film in
                    FilmDetailView(film: film)
                }
            case .error(let message):
                Text(message)
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
}

#Preview {
    FilmListView(viewModel: FilmListViewModel(filmService: MockFilmService()))
}
