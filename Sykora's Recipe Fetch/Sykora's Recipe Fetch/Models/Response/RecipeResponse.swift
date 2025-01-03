//  RecipeResponse.swift
//  Sykora's Recipe Fetch

import Foundation

public struct RecipeResponse: Codable, Sendable {
    var cuisine: String
    var name: String
    var photo_url_large: String?
    var photo_url_small: String?
    var source_url: String?
    var uuid: String
    var youtube_url: String?
}
