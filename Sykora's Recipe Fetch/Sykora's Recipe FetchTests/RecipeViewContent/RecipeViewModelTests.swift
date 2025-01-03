//  RecipeViewModelTests.swift
//  Sykora's Recipe Fetch

import XCTest
import Testing
import SwiftData
@testable import Sykora_s_Recipe_Fetch

class RecipeViewModelTests: XCTestCase {
    private var testee: RecipeViewModel?

    override func setUpWithError() throws {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: RecipePersisted.self, ImagePersisted.self, configurations: config)
            testee = RecipeViewModel(modelContainer: container)
        } catch {
            XCTFail("Failed to create container")
        }
    }
    
    func testViewModelCanFetchAndReturnValidData() async throws {
        guard let testee else {
            XCTFail("testee is null")
            return
        }
        let result = await testee.fetchRecipesInBackground()
        XCTAssertEqual(result.count, 63)
    }
    
    func testPullToRefreshClearsAndRePullsData() async throws {
        guard let testee else {
            XCTFail("testee is null")
            return
        }
        await testee.recipeActor.persistRecipes([RecipeResponse(cuisine: "Malaysian", name: "Apam Balik", uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8")])
        
        let result = await testee.fetchRecipesInBackground()
        XCTAssertEqual(result.count, 1)
        
        let pullToRefreshResult = await testee.pullToRefresh()
        XCTAssertEqual(pullToRefreshResult.count, 63)
    }
}
