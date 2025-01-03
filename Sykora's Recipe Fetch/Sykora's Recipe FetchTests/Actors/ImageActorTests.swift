//  ImageActorTests.swift
//  Sykora's Recipe Fetch

import XCTest
import Testing
import SwiftData
@testable import Sykora_s_Recipe_Fetch

class ImageActorTests: XCTestCase {
    private var testee: ImageActor?

    override func setUpWithError() throws {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: RecipePersisted.self, ImagePersisted.self, configurations: config)
            testee = ImageActor(modelContainer: container)
        } catch {
            XCTFail("Failed to create container")
        }
    }
    
    func testImageActorCanPersistsImages() async throws {
        guard let testee else {
            XCTFail("testee is null")
            return
        }
        let testImageData = UIImage(systemName: "dog.fill")?.pngData() ?? Data()
        
        await testee.persistImage(url: "test.com", imageData: testImageData)
        
        let fetchedImage = await testee.fetchPersistedImage(url: "test.com")
        
        XCTAssertNotNil(fetchedImage)
        XCTAssertEqual(fetchedImage?.pngData()?.count, testImageData.count)
    }
    
    func testImageActorClearsPersistedImages() async throws {
        guard let testee else {
            XCTFail("testee is null")
            return
        }
        let testImageData = UIImage(systemName: "dog.fill")?.pngData() ?? Data()
        
        await testee.persistImage(url: "test.com", imageData: testImageData)
        
        let fetchedImage = await testee.fetchPersistedImage(url: "test.com")
        
        XCTAssertNotNil(fetchedImage)
        
        await testee.clearImages()
        let secondFetchedImage = await testee.fetchPersistedImage(url: "test.com")
        
        XCTAssertNil(secondFetchedImage)
    }
    
    func testImageActorCanFetchImagesFromCache() async throws {
        guard let testee else {
            XCTFail("testee is null")
            return
        }
        let testImageData = UIImage(systemName: "dog.fill")?.pngData() ?? Data()
        
        await testee.persistImage(url: "test.com", imageData: testImageData)
        
        let fetchedImage = await testee.fetchImage(url: "test.com")
        
        XCTAssertNotNil(fetchedImage)
    }
    
    func testImageActorCanFetchImagesFromAPIButUponErrorReturnsDefaultImage() async throws {
        guard let testee else {
            XCTFail("testee is null")
            return
        }
        let fetchedImage = await testee.fetchImage(url: "test")
        
        XCTAssertNotNil(fetchedImage)
        XCTAssertEqual(fetchedImage, UIImage(systemName: "photo.badge.exclamationmark"))
    }
    
    func testImageActorCanFetchImagesFromAPIAndPersistsValidImage() async throws {
        guard let testee else {
            XCTFail("testee is null")
            return
        }
        let testURL = "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"
        let fetchedImage = await testee.fetchImage(url: testURL)
        
        XCTAssertNotNil(fetchedImage)
        XCTAssertEqual(fetchedImage.pngData()?.count, 92190)
        
        let persistedImage = await testee.fetchPersistedImage(url: testURL)
        
        XCTAssertNotNil(persistedImage)
    }
}
