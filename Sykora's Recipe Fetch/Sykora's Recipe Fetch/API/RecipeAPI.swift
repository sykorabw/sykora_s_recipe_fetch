//  RecipeAPI.swift
//  Sykora's Recipe Fetch

import Foundation

public protocol RecipeAPIProtocol: Sendable {
    func fetchRecipes() async -> [RecipeResponse]
}
/// Recipe API used for fetching recipe information
public final class RecipeAPI: RecipeAPIProtocol {
    /// Get a list of recipes from the recipe url
    /// - Returns: an array of RecipeResponse models or empty array if an error was encountered
    public func fetchRecipes() async -> [RecipeResponse] {
        let url = Endpoints.Recipe.fetch
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let dictionary = try JSONDecoder().decode([String: [RecipeResponse]].self, from: data)
            if let validResult = dictionary["recipes"] {
                return validResult
            } else {
                throw Errors.malformedData
            }
        } catch {
            return []
        }
    }
}
