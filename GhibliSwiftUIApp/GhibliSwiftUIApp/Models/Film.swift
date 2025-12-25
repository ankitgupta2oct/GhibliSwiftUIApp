import Foundation

struct Film: Decodable, Identifiable, Equatable {
    let id: String
    let title: String
    let image: String
    let description: String
    let director: String
    let producer: String
    let people: [String]
    
    let releaseYear: String
    let score: String
    let duration: String
    let banner: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, description, director, producer, people
        
        case releaseYear = "release_date"
        case score = "rt_score"
        case duration = "running_time"
        case banner = "movie_banner"
    }
}

import Playgrounds

#Playground {
    let url = URL(string: "https://ghibliapi.vercel.app/films")!
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode([Film].self, from: data)
    } catch {
        print(error.localizedDescription)
    }
}
