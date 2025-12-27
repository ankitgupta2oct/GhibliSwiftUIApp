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

                VStack(alignment: .leading, spacing: 10) {
                    Text(film.title)
                        .bold()
                        .font(.title2)
                    
                    Divider()
                    
                    Text("Description")
                        .bold()
                        .font(.title3)
                    Text(film.description)
                    
                    switch viewModel.peopleLoadingState {
                    case .idle:
                        EmptyView()
                    case .loading:
                        ProgressView {
                            Text("Loading...")
                        }
                    case .loaded(let people):
                        if !people.isEmpty {
                            VStack(alignment: .leading) {
                                Text("Characters")
                                    .bold()
                                    .font(.title3)
                                
                                ForEach(people) { person in
                                    Text(person.name)
                                }
                            }
                        }
                    case .error(let message):
                        Text(message)
                    }
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                FavoriteButton(filmId: film.id)
            }
        }
        .task(id: film) {
            await viewModel.fetch(for: film)
        }
    }
}

#Preview {
    @Previewable @State var favoriteManager = FavoriteManager(localStorage: MockLocalStorage())
    NavigationStack {
        FilmDetailScreen(film: GhibliMocks.instance.films.first!, viewModel: FilmDetailViewModel(personService: MockPersonService()))
            .environment(favoriteManager)
    }
}
