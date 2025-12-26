import Foundation

struct Person: Decodable, Identifiable, Hashable {
    let id, name, gender, age: String
    let films: [String]
    let species, url: String
    
    let eyeColor, hairColor: String

    enum CodingKeys: String, CodingKey {
        case id, name, gender, age
        case films, species, url
        
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
    }
}

import Playgrounds

#Playground {
    let url = URL(string: "https://ghibliapi.vercel.app/people/598f7048-74ff-41e0-92ef-87dc1ad980a9")!
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(Person.self, from: data)
    } catch {
        print(error.localizedDescription)
    }
}
