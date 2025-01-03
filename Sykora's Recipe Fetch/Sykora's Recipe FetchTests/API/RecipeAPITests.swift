//  RecipeAPITests.swift
//  Sykora's Recipe Fetch

import XCTest
import Testing
@testable import Sykora_s_Recipe_Fetch

class RecipeAPITests: XCTestCase {
    private var testee: RecipeAPI?

    override func setUpWithError() throws {
        testee = RecipeAPI()
    }
    
    // Normally I'd have a URLProtocolMock setup for testing these in isolation.
    // Something similar to https://www.hackingwithswift.com/articles/153/how-to-test-ios-networking-code-the-easy-way
    func testRecipeAPICanReturnValidResults() async throws {
        guard let testee else {
            XCTFail("testee is null")
            return
        }
        let result = await testee.fetchRecipes()
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 63) // needs better isolation and practical expectations instead of this
    }
}
