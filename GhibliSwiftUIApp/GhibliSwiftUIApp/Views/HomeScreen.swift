import SwiftUI

struct HomeScreen: View {
    @State private var filmListViewModel = FilmListViewModel()
    @State private var favoriteManager = FavoriteManager(localStorage: LocalStorageUserDefault())
    
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                MovieScreen(filmListViewModel: filmListViewModel)
                    .environment(favoriteManager)
            }
            
            Tab("Favorite", systemImage: "heart") {
                FavoriteScreen(filmListViewModel: filmListViewModel)
                    .environment(favoriteManager)
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }
            
            Tab(role: .search) {
                SearchScreen()
            }
        }
    }
}

#Preview {
    HomeScreen()
}
