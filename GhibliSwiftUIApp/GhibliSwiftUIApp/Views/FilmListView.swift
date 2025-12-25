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
                ContentUnavailableView("No Films found", systemImage: "rectangle.and.text.magnifyingglass")
            case .loading:
                ProgressView {
                    Text("Loading...")
                }
            case .loaded(let films):
                List {
                    ForEach(films) { film in
                        Text(film.title)
                    }
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
