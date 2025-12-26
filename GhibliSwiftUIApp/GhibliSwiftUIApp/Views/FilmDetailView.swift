import SwiftUI

struct FilmDetailView: View {
    let film: Film
    @State var viewModel: FilmDetailViewModel
    
    init(film: Film, viewModel: FilmDetailViewModel = FilmDetailViewModel(personService: PersonServiceImp())) {
        self.film = film
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            AsyncImage(url: URL(string: film.banner)) { phase in
                switch phase {
                case .empty:
                    Color.gray
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(_):
                    Image(systemName: "person.crop.circle.badge.exclamationmark")
                @unknown default:
                    fatalError()
                }
            }
            .frame(height: 200)
            
            Text(film.title)
            
            Divider()
            
            Text("Characters")
                .font(.title3)
            
            switch viewModel.peopleLoadingState {
            case .idle:
                EmptyView()
            case .loading:
                ProgressView {
                    Text("Loading...")
                }
            case .loaded(let people):
                List {
                    ForEach(people) { person in
                        Text(person.name)
                    }
                }
            case .error(let message):
                Text(message)
            }
        }
        .padding()
        .task(id: film) {
            await viewModel.fetch(for: film)
        }
    }
}

#Preview {
    FilmDetailView(film: GhibliMocks.instance.films.first!, viewModel: FilmDetailViewModel(personService: MockPersonService()))
}
