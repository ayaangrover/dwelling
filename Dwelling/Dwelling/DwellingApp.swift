import SwiftUI

@main
struct AyaanApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentTabView: View {
    var body: some View {
        TabView {
            NewsView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            LocationView()
                .tabItem {
                    Label("Location", systemImage: "map")
                }
        }
    }
}
