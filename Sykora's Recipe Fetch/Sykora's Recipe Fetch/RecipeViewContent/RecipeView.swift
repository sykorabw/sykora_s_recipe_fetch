//  RecipeView.swift
//  Sykora's Recipe Fetch

import SwiftUI
import SwiftData

struct RecipeView: View {
    let modelContainer: ModelContainer
    @State var viewModel: RecipeViewModel
    @State var recipes: [RecipeTransfer] = []
    @State var isLoading: Bool = false
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        viewModel = RecipeViewModel(modelContainer: modelContainer)
    }
    var body: some View {
        header
        columnTitles
        ScrollView {
            LazyVStack(spacing: 0) {
                if isLoading {
                    ProgressView()
                } else {
                    if recipes.isEmpty {
                        Text("No Recipes Found")
                    } else {
                        ForEach(recipes, id: \.id) { aRecipe in
                            RecipeRow(modelContainer: modelContainer, aRecipe: aRecipe)
                        }
                    }
                }
            }
        }
        .onAppear{
            Task() {
                isLoading = true
                recipes = await viewModel.fetchRecipesInBackground()
                isLoading = false
            }
        }
        .refreshable {
            Task() {
                isLoading = true
                recipes = await viewModel.pullToRefresh()
                isLoading = false
            }
        }
    }
    
    var header: some View {
        HStack {
            Text("Welcome to\nSykora's Recipe Fetch")
            Image(systemName: "dog.fill")
                .accessibilityHidden(true)
        }
        .font(.title)
        .foregroundStyle(Color.brown)
    }
    
    var columnTitles: some View {
        HStack {
            Text("Recipe Name")
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityLabel("Recipe Name, Middle Column Title")
            Divider()
            Text("Cuisine Type")
                .frame(width: 100)
                .accessibilityLabel("Cuisine Type, Right Column Title")
        }
        .font(.system(size: 14))
        .padding(.leading, UIDevice.current.userInterfaceIdiom == .pad ? 400 : 180)
        .padding(.bottom, -10)
        .frame(height: 20)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: RecipePersisted.self, ImagePersisted.self, configurations: config)
        return RecipeView(modelContainer: container)
    } catch {
        fatalError("Failed to create container")
    }
}
