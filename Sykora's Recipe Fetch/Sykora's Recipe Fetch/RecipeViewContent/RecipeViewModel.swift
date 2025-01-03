//  RecipeViewModel.swift
//  Sykora's Recipe Fetch

import SwiftUI
import SwiftData

@Observable
final class RecipeViewModel: Sendable {
    let modelContainer: ModelContainer
    let recipeActor: RecipeActor
    let imageActor: ImageActor
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        recipeActor = RecipeActor(modelContainer: modelContainer)
        imageActor = ImageActor(modelContainer: modelContainer)
    }
    
    func fetchRecipesInBackground() async -> [RecipeTransfer] {
        return await recipeActor.fetchRecipes()
    }
    
    func pullToRefresh() async -> [RecipeTransfer] {
        await recipeActor.clearRecipes()
        await imageActor.clearImages()
        return await recipeActor.fetchRecipes()
    }
}
