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
            
            GuardianNewsView()
                .tabItem {
                    Label("Guardian", systemImage: "newspaper.fill")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
