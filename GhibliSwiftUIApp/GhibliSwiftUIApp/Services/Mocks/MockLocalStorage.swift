import Foundation

class MockLocalStorage: LocalStorage {
    private(set) var storage = [Any]()
    
    func load(for key: String) -> Any? {
        storage
    }
    
    func save(value: Any?, for key: String) {
        storage.append(value!)
    }
}
