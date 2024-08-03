import SwiftUI

struct WebPageView: View {
    var body: some View {
        NavigationView {
            WebView(url: URL(string: "https://msbell.harker.xyz")!)
        }
    }
}

struct WebPageView_Previews: PreviewProvider {
    static var previews: some View {
        WebPageView()
    }
}
