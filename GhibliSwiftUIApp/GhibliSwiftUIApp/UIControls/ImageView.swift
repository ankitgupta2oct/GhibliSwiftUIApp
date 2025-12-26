import SwiftUI

struct ImageView: View {
    let url: String
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                Color.gray.opacity(0.3)
                    .overlay {
                        ProgressView()
                            .controlSize(.large)
                    }
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
    }
}

#Preview("Example1") {
    ImageView(url: "https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg")
}

#Preview("Example2") {
    ImageView(url: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg")
}
