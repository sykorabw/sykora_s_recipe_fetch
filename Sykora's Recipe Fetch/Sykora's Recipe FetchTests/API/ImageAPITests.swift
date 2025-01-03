//  ImageAPITests.swift
//  Sykora's Recipe Fetch

import XCTest
import Testing
@testable import Sykora_s_Recipe_Fetch

class ImageAPITests: XCTestCase {
    private var testee: ImageAPI?

    override func setUpWithError() throws {
        testee = ImageAPI()
    }
    
    // Normally I'd have a URLProtocolMock setup for testing these in isolation.
    // Something similar to https://www.hackingwithswift.com/articles/153/how-to-test-ios-networking-code-the-easy-way
    func testImageAPICanReturnValidResult() async throws {
        guard let testee else {
            XCTFail("testee is null")
            return
        }
        let testURL = "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"
        let result = await testee.downloadImageFrom(urlString: testURL)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.count, 11500)
    }
    
    func testImageAPIReturnsNilResultWhenAnErrorIsEncountered()async throws {
        guard let testee else {
            XCTFail("testee is null")
            return
        }
        let result = await testee.downloadImageFrom(urlString: "invalid")
        XCTAssertNil(result)
    }
}
