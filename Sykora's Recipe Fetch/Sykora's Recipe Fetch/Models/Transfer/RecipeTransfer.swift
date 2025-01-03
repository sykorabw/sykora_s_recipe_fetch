//  RecipeTransfer.swift
//  Sykora's Recipe Fetch

import Foundation

final class RecipeTransfer: Sendable, Identifiable {
    let id: UUID
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let youtubeUrl: String?
    
    init(id: UUID, cuisine: String, name: String, photoUrlLarge: String?, photoUrlSmall: String?, sourceUrl: String?, youtubeUrl: String?) {
        self.id = id
        self.cuisine = cuisine
        self.name = name
        self.photoUrlLarge = photoUrlLarge
        self.photoUrlSmall = photoUrlSmall
        self.sourceUrl = sourceUrl
        self.youtubeUrl = youtubeUrl
    }
}
