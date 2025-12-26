import SwiftUI

struct SearchScreen: View {
    @State private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.searchLoadingState {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                case .loaded(let films):
                    if films.isEmpty {
                        ContentUnavailableView("No search results found", systemImage: "rectangle.and.text.magnifyingglass")
                    } else {
                        List {
                            ForEach(films) { film in
                                RowView(film: film)
                            }
                        }
                    }
                case .error(let message):
                    Text(message)
                }
            }
            .task(id: viewModel.searchText) {
                try? await Task.sleep(for: .milliseconds(500))
                await viewModel.search()
            }
            .searchable(text: $viewModel.searchText, prompt: "Type here...")
        }
    }
    
    private struct RowView: View {
        let film: Film
        var body: some View {
            HStack {
                ImageView(url: film.banner)
                    .frame(width: 70, height: 100)
                Text(film.title)
                    .bold()
            }
        }
    }
}

#Preview {
    SearchScreen()
}
