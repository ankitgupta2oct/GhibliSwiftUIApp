import Foundation

@Observable
final class FilmDetailViewModel {
    @ObservationIgnored private let personService: PersonService
    
    var peopleLoadingState: ContentLoadingState<[Person]> = .idle
    
    init(personService: PersonService) {
        self.personService = personService
    }
    
    func fetch(for film: Film) async {
        guard peopleLoadingState != .loading else { return }
        
        peopleLoadingState = .loading
        let people = await fetchPeople(for: film)
        peopleLoadingState = .loaded(people)
    }
}

private extension FilmDetailViewModel {
    func fetchPeople(for film: Film) async -> [Person] {
        await withTaskGroup(of: Person?.self, returning: [Person].self) { group in
            for url in film.people {
                group.addTask {
                    try? await self.personService.fetchPerson(with: url)
                }
            }
            
            var people = [Person]()
            for await person in group {
                if let person {
                    people.append(person)
                }
            }
            
            return people
        }
    }
}
