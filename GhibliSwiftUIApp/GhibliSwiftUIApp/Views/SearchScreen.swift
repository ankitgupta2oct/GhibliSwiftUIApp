import SwiftUI

struct SearchScreen: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            Text(searchText)
                .searchable(text: $searchText, prompt: "Type here...")
        }
    }
}

#Preview {
    SearchScreen()
}
