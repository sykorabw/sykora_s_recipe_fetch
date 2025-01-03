//  ImageFetchView.swift
//  Sykora's Recipe Fetch

import SwiftUI
import SwiftData

struct ImageFetchView: View {
    let modelContainer: ModelContainer
    @State var viewModel: ImageFetchViewModel
    @State var image = UIImage()
    @State var isLoading: Bool = true
    private let name: String
    
    init(modelContainer: ModelContainer, url: String, name: String) {
        self.modelContainer = modelContainer
        viewModel = ImageFetchViewModel(modelContainer: modelContainer, url: url)
        self.name = name
    }
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                Image(uiImage: image)
                    .resizable()
                    .accessibilityLabel(Text(name))
            }
        }
        .onAppear{
            Task() {
                image = await viewModel.fetchImageInBackground()
                isLoading = false
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: RecipePersisted.self, ImagePersisted.self, configurations: config)
        return ImageFetchView(modelContainer: container, url: "", name: "")
    } catch {
        fatalError("Failed to create container")
    }
}
