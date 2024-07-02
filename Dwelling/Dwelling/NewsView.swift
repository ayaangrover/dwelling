import SwiftUI

struct NewsView: View {
    @StateObject var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.articles) { article in
                VStack(alignment: .leading) {
                    if let multimedia = article.multimedia?.first(where: { $0.format == "superJumbo" }) {
                        AsyncImage(url: URL(string: multimedia.url))
                            .aspectRatio(contentMode: .fit)
                    }
                    Text(article.title)
                        .font(.headline)
                    Text(article.abstract)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            .navigationTitle("Top Headlines")
        }
        .onAppear {
            viewModel.fetchNews()
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
