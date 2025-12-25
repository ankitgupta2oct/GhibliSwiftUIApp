import Foundation

final class GhibliMocks {
    let films: [Film]
    let person: Person
    
    static let instance = GhibliMocks()
    
    private init() {
        films = loadJson([Film].self, filePath: "SampleFilms")!
        person = loadJson(Person.self, filePath: "SamplePerson")!
        
        func loadJson<T: Decodable>(_ type: T.Type, filePath: String, withExtension: String = "json") -> T? {
            guard let url = Bundle.main.url(forResource: filePath, withExtension: withExtension) else {
                return nil
            }
            
            do {
                let data = try Data(contentsOf: url)
                return try JSONDecoder().decode(type, from: data)
            } catch {
                return nil
            }
        }
    }
}
