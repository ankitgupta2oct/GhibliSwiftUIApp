import SwiftUI

struct FavoriteScreen: View {
    let filmListViewModel: FilmListViewModel
    var body: some View {
        NavigationStack {
            Text("Favorite")
        }
    }
}

#Preview {
    FavoriteScreen(filmListViewModel: FilmListViewModel(filmService: MockFilmService()))
}
