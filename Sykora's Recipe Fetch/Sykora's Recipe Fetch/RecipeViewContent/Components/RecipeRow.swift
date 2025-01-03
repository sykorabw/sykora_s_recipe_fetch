//  RecipeRow.swift
//  Sykora's Recipe Fetch

import SwiftUI
import SwiftData

struct RecipeRow: View {
    @Environment(\.colorScheme) var colorScheme
    let modelContainer: ModelContainer
    var aRecipe: RecipeTransfer
    let imageSize: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 400 : 180
    
    init(modelContainer: ModelContainer, aRecipe: RecipeTransfer) {
        self.modelContainer = modelContainer
        self.aRecipe = aRecipe
    }
    
    var body: some View {
        FlippyCard(front: {front}, back: {back})
    }
    
    var front: some View {
        HStack (alignment: .top) {
            if let urlString = (UIDevice.current.userInterfaceIdiom == .pad ? aRecipe.photoUrlLarge : aRecipe.photoUrlSmall) {
                ImageFetchView(modelContainer: modelContainer, url: urlString, name: aRecipe.name)
                    .frame(width: imageSize, height: imageSize)
                    .overlay{
                            Image(systemName: "arrow.trianglehead.2.counterclockwise.rotate.90")
                                .foregroundStyle(.blue)
                                .padding(.trailing, imageSize - 40)
                                .padding(.bottom, imageSize - 50)
                                .accessibilityLabel("tap card to view back side")
                    }
            }
            VStack {
                HStack {
                    Text(aRecipe.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                        .padding(.leading, 10)
                    Divider()
                        .padding(.bottom, -6)
                    Text(aRecipe.cuisine)
                        .frame(width: 100, alignment: .center)
                        .padding(.top, 10)
                }
                if let validYoutubeUrl = aRecipe.youtubeUrl, let youtubeUrl = URL(string: validYoutubeUrl) {
                    Link(destination: youtubeUrl) {
                        HStack {
                            Spacer()
                            Text("Open \(aRecipe.name) Video")
                                .multilineTextAlignment(.leading)
                            Image(systemName: "link")
                            Spacer()
                        }
                        .font(.headline)
                        .foregroundStyle(.white)
                    }
                    .background(Color.blue.opacity(0.8))
                    .border(.gray)
                    .accessibilityHint(Text("Tapping this will take you to an external link"))
                }
            }
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
    }
    
    var back: some View {
        VStack {
            Spacer()
            if let validSourceURL = aRecipe.sourceUrl {
                Text("Source URL:\n\(validSourceURL)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text("No Source URL Found!")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
        }
        .padding(.leading, 10)
        .frame(height: imageSize)
        .background(colorScheme == .dark ? Color.black : Color.white)
    }
}

#Preview {
    do {
        let aRecipe = RecipeTransfer(id: UUID(uuidString: "0c6ca6e7-e32a-4053-b824-1dbf749910d8")!, cuisine: "Malaysian", name: "Apam Balik", photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg", photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ", youtubeUrl: "https://www.youtube.com/watch?v=rp8Slv4INLk")
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: RecipePersisted.self, ImagePersisted.self, configurations: config)
        return RecipeRow(modelContainer: container, aRecipe: aRecipe).frame(height:180)
    } catch {
        fatalError("Failed to create container")
    }
}
