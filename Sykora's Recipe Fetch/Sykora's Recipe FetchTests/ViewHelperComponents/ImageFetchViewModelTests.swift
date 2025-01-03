//  ImageFetchViewModelTests.swift
//  Sykora's Recipe Fetch

import XCTest
import Testing
import SwiftData
@testable import Sykora_s_Recipe_Fetch

class ImageFetchViewModelTests: XCTestCase {
    private var testee: ImageFetchViewModel?
    
    func testViewModelCanFetchAndReturnValidImage() async throws {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: RecipePersisted.self, ImagePersisted.self, configurations: config)
            testee = ImageFetchViewModel(modelContainer: container, url: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
        } catch {
            XCTFail("Failed to create container")
        }
        let result = await testee?.fetchImageInBackground()
        XCTAssertEqual(result?.pngData()?.count, 92190)
    }
    
    func testViewModelWillStillHaveAFallbackImageIfFetchFails() async throws {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: RecipePersisted.self, ImagePersisted.self, configurations: config)
            testee = ImageFetchViewModel(modelContainer: container, url: "invalid")
        } catch {
            XCTFail("Failed to create container")
        }
        let result = await testee?.fetchImageInBackground()
        XCTAssertEqual(result, UIImage(systemName: "photo.badge.exclamationmark"))
    }
}
