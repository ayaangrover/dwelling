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
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.articles = Array(result.results.prefix(10))
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
