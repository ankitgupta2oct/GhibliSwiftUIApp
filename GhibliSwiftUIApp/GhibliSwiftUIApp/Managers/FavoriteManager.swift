import Foundation

@Observable
final class FavoriteManager {
    private(set) var favoritesIds = Set<String>()
    private let key = "com.storage.favorite"
    private let localStorage: LocalStorage
    
    init(localStorage: LocalStorage) {
        self.localStorage = localStorage
        load()
    }
    
    func toggleFavorite(for id: String) {
        if favoritesIds.contains(id) {
            favoritesIds.remove(id)
        } else {
            favoritesIds.insert(id)
        }
        save()
    }
    
    func isFavorite(for id: String) -> Bool {
        favoritesIds.contains(id)
    }
}

private extension FavoriteManager {
    func load() {
        if let ids = localStorage.load(for: key) as? [String] {
            favoritesIds = Set(ids)
        }
    }
    
    func save() {
        localStorage.save(value: Array(favoritesIds), for: key)
    }
}
