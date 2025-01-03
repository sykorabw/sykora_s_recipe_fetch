//  RecipeActor.swift
//  Sykora's Recipe Fetch

import Foundation
import SwiftData

@ModelActor
actor RecipeActor: Sendable {
    private var context: ModelContext { modelExecutor.modelContext }
    var recipeAPI = RecipeAPI()
    
    /// persists recipe data
    /// - Parameters:
    ///   - recipes: an array of RecipeResponse
    func persistRecipes(_ recipes: [RecipeResponse]) {
        let recipePersisteds: [RecipePersisted] = recipes.map{RecipePersisted(cuisine: $0.cuisine, name: $0.name, photoUrlLarge: $0.photo_url_large, photoUrlSmall: $0.photo_url_small, sourceUrl: $0.source_url, uuid: $0.uuid, youtubeUrl: $0.youtube_url)}
        recipePersisteds.forEach{ context.insert($0) }
        try? context.save()
    }
    
    /// clears all recipe data from the persistence database
    func clearRecipes() async {
        try? context.delete(model: RecipePersisted.self)
    }
    
    /// fetches recipe lists from either the API or persistence database
    /// - Returns: an array of RecipeTransfer
    func fetchRecipes() async -> [RecipeTransfer] {
        let persistedResult = await fetchPersistedRecipes()
        guard !persistedResult.isEmpty else {
            return await fetchAPIRecipes()
        }
        return persistedResult
    }
    
    /// fetches recipes from the API
    /// - Returns: an array of RecipeTransfer
    func fetchAPIRecipes() async -> [RecipeTransfer] {
        let recipeResponse = await recipeAPI.fetchRecipes()
        do {
            let recipeTransfers: [RecipeTransfer] = try recipeResponse.map{
                if let validUUID = UUID(uuidString: $0.uuid) {
                    return RecipeTransfer(id: validUUID, cuisine: $0.cuisine, name: $0.name, photoUrlLarge: $0.photo_url_large, photoUrlSmall: $0.photo_url_small, sourceUrl: $0.source_url, youtubeUrl: $0.youtube_url)
                } else {
                    throw Errors.malformedData
                }
            }
            self.persistRecipes(recipeResponse)
            return recipeTransfers
        } catch {
            return []
        }
    }
    
    /// fetches persisted recipes from the persistence database
    /// - Returns: an array of RecipeTransfer
    func fetchPersistedRecipes() async -> [RecipeTransfer] {
        let recipeDescriptor = FetchDescriptor<RecipePersisted>(sortBy: [SortDescriptor(\RecipePersisted.name)])
        do {
            let recipes: [RecipePersisted] = try context.fetch(recipeDescriptor)
            let recipeTransfers: [RecipeTransfer] = try recipes.map{
                if let validUUID = UUID(uuidString: $0.uuid) {
                    return RecipeTransfer(id: validUUID, cuisine: $0.cuisine, name: $0.name, photoUrlLarge: $0.photoUrlLarge, photoUrlSmall: $0.photoUrlSmall, sourceUrl: $0.sourceUrl, youtubeUrl: $0.youtubeUrl)
                } else {
                    throw Errors.malformedData
                }
            }
            return recipeTransfers
        } catch {
            return []
        }
    }
}
