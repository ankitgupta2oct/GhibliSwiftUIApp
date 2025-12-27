import SwiftUI

struct HomeScreen: View {
    @State private var filmListViewModel = FilmListViewModel()
    @State private var favoriteManager = FavoriteManager(localStorage: LocalStorageUserDefault())
    
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                MovieScreen(filmListViewModel: filmListViewModel)
            }
            
            Tab("Favorite", systemImage: "heart") {
                FavoriteScreen(filmListViewModel: filmListViewModel)
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }
            
            Tab(role: .search) {
                SearchScreen()
            }
        }
        .environment(favoriteManager)
    }
}

#Preview {
    HomeScreen()
}
