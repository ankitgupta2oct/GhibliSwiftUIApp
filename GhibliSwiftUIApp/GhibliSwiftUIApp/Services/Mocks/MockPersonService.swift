import Foundation

struct MockPersonService: PersonService {
    func fetchPerson(with url: String) async throws -> Person {
        GhibliMocks.instance.person
    }
}
