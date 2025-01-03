//  Sykora_s_Recipe_FetchApp.swift
//  Sykora's Recipe Fetch

import SwiftUI
import SwiftData

@main
struct Sykora_s_Recipe_FetchApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: RecipePersisted.self, ImagePersisted.self)
        } catch {
            fatalError("Faled to create contaiiner")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            RecipeView(modelContainer: container)
        }
    }
}
