import SwiftUI

struct AsyncImage: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Image

    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
    }

    var body: some View {
        image
            .onAppear {
                loader.load()
            }
    }

    private var image: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL?

    init(url: URL?) {
        self.url = url
    }

    func load() {
        guard let url = url else {
            print("Invalid URL")
            return
        }

        print("Loading image from URL: \(url)")

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to load image:", error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response or status code")
                return
            }

            guard let data = data else {
                print("No image data")
                return
            }

            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
                print("Image loaded successfully")
            } else {
                print("Failed to create image from data")
            }
        }.resume()
    }
}
