import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        NavigationStack {
            Text("Settings View")
                .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsScreen()
}
