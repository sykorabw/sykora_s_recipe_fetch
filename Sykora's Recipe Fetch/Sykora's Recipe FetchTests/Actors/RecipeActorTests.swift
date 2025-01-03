//  RecipeActor.swift
//  Sykora's Recipe Fetch

import XCTest
import Testing
import SwiftData
@testable import Sykora_s_Recipe_Fetch

class RecipeActorTests: XCTestCase {
    private var testee: RecipeActor?

    override func setUpWithError() throws {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: RecipePersisted.self, ImagePersisted.self, configurations: config)
            testee = RecipeActor(modelContainer: container)
        } catch {
            XCTFail("Failed to create container")
        }
    }
    
    func testRecipeActorCanPersistsRecipes() async throws {
        guard let testee else {
            XCTFail("testee is null")
            return
        }
        await testee.persistRecipes([RecipeResponse(cuisine: "Malaysian", name: "Apam Balik", uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8")])
        
        let fetchedRecipes = await testee.fetchPersistedRecipes()
        
        XCTAssertFalse(fetchedRecipes.isEmpty)
        XCTAssertEqual(fetchedRecipes[0].name, "Apam Balik")
    }
    
    func testRecipeActorClearsPersistedRecipes() async throws {
        guard let testee else {
            XCTFail("testee is null")
            return
        }
        await testee.persistRecipes([RecipeResponse(cuisine: "Malaysian", name: "Apam Balik", uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8")])
        
        let fetchedRecipes = await testee.fetchPersistedRecipes()
        
        XCTAssertFalse(fetchedRecipes.isEmpty)
        
        await testee.clearRecipes()
        let secondFetchedRecipes = await testee.fetchPersistedRecipes()
        
        XCTAssertTrue(secondFetchedRecipes.isEmpty)
    }
    
    func testRecipeActorCanFetchRecipesFromCache() async throws {
        guard let testee else {
            XCTFail("testee is null")
            return
        }
        await testee.persistRecipes([RecipeResponse(cuisine: "Malaysian", name: "Apam Balik", uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8")])
        
        let fetchedRecipes = await testee.fetchRecipes()
        
        XCTAssertFalse(fetchedRecipes.isEmpty)
        XCTAssertEqual(fetchedRecipes[0].name, "Apam Balik")
    }
    
    func testRecipeActorCanFetchRecipesFromAPIAndPersistsThem() async throws {
        guard let testee else {
            XCTFail("testee is null")
            return
        }
        let fetchedRecipes = await testee.fetchRecipes()
        
        XCTAssertFalse(fetchedRecipes.isEmpty)
        
        let persistedRecipes = await testee.fetchPersistedRecipes()
        
        XCTAssertFalse(persistedRecipes.isEmpty)
    }
}
