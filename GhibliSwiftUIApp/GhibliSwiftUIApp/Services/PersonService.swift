import Foundation

protocol PersonService: Sendable {
    func fetchPerson(with url: String) async throws -> Person
}

struct PersonServiceImp: PersonService {
    let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImp()) {
        self.networkService = networkService
    }
    
    func fetchPerson(with url: String) async throws -> Person {
        try await networkService.data(type: Person.self, url)
    }
}
