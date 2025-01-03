//  ImageAPIAndCache.swift
//  Sykora's Recipe Fetch

import Foundation
import UIKit

public protocol ImageAPIProtocol: Sendable {
    func downloadImageFrom(urlString: String) async -> Data?
}

/// Image API used for downloading image data
public final class ImageAPI: ImageAPIProtocol {
    /// Download an image from the given url string
    /// - Parameters:
    ///   - urlString: String that will be converted into a URL
    /// - Returns: Data (image data) or nil if there was an error
    public func downloadImageFrom(urlString: String) async -> Data? {
        guard let url = URL(string: urlString) else { return nil } // should log some error for not parsing the URL string
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            return nil
        }
    }
}
