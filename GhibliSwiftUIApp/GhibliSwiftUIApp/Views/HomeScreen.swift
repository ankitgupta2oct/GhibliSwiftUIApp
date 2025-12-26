import SwiftUI

struct HomeScreen: View {
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                MovieScreen()
            }
            
            Tab("Favorite", systemImage: "heart") {
                FavoriteScreen()
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
