//  ImageFetchViewModel.swift
//  Sykora's Recipe Fetch

import SwiftUI
import SwiftData

@Observable
final class ImageFetchViewModel: Sendable {
    let modelContainer: ModelContainer
    let url: String
    let imageActor: ImageActor
    
    init(modelContainer: ModelContainer, url: String) {
        self.modelContainer = modelContainer
        imageActor = ImageActor(modelContainer: modelContainer)
        self.url = url
    }
    
    func fetchImageInBackground() async -> UIImage {
        return await imageActor.fetchImage(url: url)
    }
}
