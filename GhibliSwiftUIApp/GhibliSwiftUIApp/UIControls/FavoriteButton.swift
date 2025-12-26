import SwiftUI

struct FavoriteButton: View {
    let filmId: String
    @Environment(FavoriteManager.self) private var favoriteManager
    
    private var isFavorite: Bool {
        favoriteManager.isFavorite(for: filmId)
    }
    
    var body: some View {
        Button {
            favoriteManager.toggleFavorite(for: filmId)
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? .red : .primary)
        }
    }
}
