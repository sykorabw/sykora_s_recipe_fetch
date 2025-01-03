//  ImagePersisted.swift
//  Sykora's Recipe Fetch

import Foundation
import SwiftData

@Model
public class ImagePersisted {
    @Attribute(.unique) var url: String
    @Attribute(.externalStorage) var imageData: Data
    
    init(url: String, imageData: Data) {
        self.url = url
        self.imageData = imageData
    }
}
