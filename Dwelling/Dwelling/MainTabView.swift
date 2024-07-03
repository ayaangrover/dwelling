import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NYTView()
                .tabItem {
                    Label("NYT", systemImage: "newspaper")
                }
            
            SportsNewsView()
                .tabItem {
                    Label("Sports", systemImage: "sportscourt")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
