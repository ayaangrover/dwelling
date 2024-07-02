import Foundation

class NewsViewModel: ObservableObject {
    @Published var articles = [Article]()
    
    private let apiKey = "DYGdeGsK3PoebT5s9vGguTWMwZQxXGS4"  // Replace with your actual API key
    private let urlString = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key="
    
    init() {
        fetchNews()
    }
    
    func fetchNews() {
        guard let url = URL(string: "\(urlString)\(apiKey)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch data:", error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.articles = Array(result.results.prefix(50))
                    for article in self.articles {
                        if let multimedia = article.multimedia {
                            for media in multimedia {
                                print("Media URL: \(media.url), Format: \(media.format)")
                            }
                        }
                    }
                    print("Articles fetched: \(self.articles.count)")
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }
}

struct NewsResponse: Codable {
    let results: [Article]
}
