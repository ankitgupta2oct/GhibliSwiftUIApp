import Foundation

protocol LocalStorage {
    func load(for key: String) -> Any?
    func save(value: Any?, for key: String)
}

final class LocalStorageUserDefault: LocalStorage {
    func load(for key: String) -> Any? {
        UserDefaults.standard.object(forKey: key)
    }
    
    func save(value: Any?, for key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
}
