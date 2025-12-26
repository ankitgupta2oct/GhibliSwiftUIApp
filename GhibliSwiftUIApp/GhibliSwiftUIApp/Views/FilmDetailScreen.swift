import SwiftUI

struct FilmDetailScreen: View {
    let film: Film
    @State var viewModel: FilmDetailViewModel
    
    init(film: Film, viewModel: FilmDetailViewModel = FilmDetailViewModel(personService: PersonServiceImp())) {
        self.film = film
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageView(url: film.banner)
                    .scaledToFill()
                    .frame(height: 200)

                VStack(alignment: .leading) {
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
                        VStack {
                            ForEach(people) { person in
                                Text(person.name)
                            }
                        }
                    case .error(let message):
                        Text(message)
                    }
                }
                .padding()
            }
        }
        .task(id: film) {
            await viewModel.fetch(for: film)
        }
    }
}

#Preview {
    FilmDetailScreen(film: GhibliMocks.instance.films.first!, viewModel: FilmDetailViewModel(personService: MockPersonService()))
}
