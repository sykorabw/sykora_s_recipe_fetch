//  ImageActor.swift
//  Sykora's Recipe Fetch

import Foundation
import SwiftData
import UIKit

@ModelActor
actor ImageActor: Sendable {
    private var context: ModelContext { modelExecutor.modelContext }
    var imageAPI = ImageAPI()
    
    /// persists image data by the provided url
    /// - Parameters:
    ///   - url: url string used to identify the image
    ///   - imageData: image data to persist
    func persistImage(url: String, imageData: Data) {
        let imagePersist = ImagePersisted(url: url, imageData: imageData)
        context.insert(imagePersist)
        try? context.save()
    }
    
    /// clears all images from the persisted database
    func clearImages() async {
        try? context.delete(model: ImagePersisted.self)
    }
    
    /// fetches an image either from persistence or from the API call based on the URL
    /// - Parameters:
    ///   - url: url string where the image is located
    /// - Returns: a UIImage if found, otherwise it returns a default error image
    func fetchImage(url: String) async -> UIImage {
        if let persistedResult = await fetchPersistedImage(url: url) {
            return persistedResult
        } else {
            return await fetchAPIImage(url: url)
        }
    }
    
    /// fetches an image from the API based on the URL provided
    /// - Parameters:
    ///   - url: url string where the image is located
    /// - Returns: a UIImage if found, otherwise it returns a default error image
    func fetchAPIImage(url: String) async -> UIImage {
        let imageResponse = await imageAPI.downloadImageFrom(urlString: url)
        if let validImageResponse = imageResponse {
            if let validImage = UIImage(data: validImageResponse) {
                self.persistImage(url: url, imageData: validImageResponse)
                return validImage
            } else {
                return UIImage(systemName: "photo.badge.exclamationmark")! // I normally wouldn't force things, but this is never going to fail.
            }
        } else {
            return UIImage(systemName: "photo.badge.exclamationmark")! // I normally wouldn't force things, but this is never going to fail.
        }
    }
    
    /// fetches an image from the persistence database based on the url
    /// - Parameters:
    ///   - url: url string where the image is located
    /// - Returns: a UIImage if found, otherwise it returns nil
    func fetchPersistedImage(url: String) async -> UIImage? {
        let predicate = #Predicate<ImagePersisted> { image in
            image.url == url
        }
        let imageDescriptor = FetchDescriptor<ImagePersisted>(predicate: predicate)
        do {
            let image: ImagePersisted? = try context.fetch(imageDescriptor).first
            if let validImageData = image?.imageData, let validImage = UIImage(data: validImageData) {
                self.persistImage(url: url, imageData: validImageData)
                return validImage
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
