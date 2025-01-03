//  RecipePersisted.swift
//  Sykora's Recipe Fetch

import Foundation
import SwiftData

@Model
public class RecipePersisted {
    var cuisine: String
    var name: String
    var photoUrlLarge: String?
    var photoUrlSmall: String?
    var sourceUrl: String?
    var uuid: String
    var youtubeUrl: String?
    
    init(cuisine: String, name: String, photoUrlLarge: String?, photoUrlSmall: String?, sourceUrl: String?, uuid: String, youtubeUrl: String?) {
        self.cuisine = cuisine
        self.name = name
        self.photoUrlLarge = photoUrlLarge
        self.photoUrlSmall = photoUrlSmall
        self.sourceUrl = sourceUrl
        self.uuid = uuid
        self.youtubeUrl = youtubeUrl
    }
}
