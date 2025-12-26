import SwiftUI

struct MovieScreen: View {
    let filmListViewModel: FilmListViewModel
    var body: some View {
        NavigationStack {
            FilmListView(viewModel: filmListViewModel, contentUnavailableText: "No films found")
        }
    }
}

#Preview {
    MovieScreen(filmListViewModel: FilmListViewModel(filmService: MockFilmService()))
}
