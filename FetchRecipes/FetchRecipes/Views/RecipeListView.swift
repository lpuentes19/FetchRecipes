//
//  RecipeListView.swift
//  FetchRecipes
//
//  Created by Luis Puentes on 3/13/25.
//

import SwiftUI

struct RecipeListView: View {
    @State var recipes: [Recipe] = []
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if recipes.isEmpty {
                    GeometryReader { geo in
                        ScrollView {
                            EmptyListView()
                                .frame(width: geo.size.width, height: geo.size.height)
                        }
                        .refreshable {
                            fetchAndSortRecipes()
                        }
                    }
                } else {
                    List(recipes) { recipe in
                        HStack(spacing: 16) {
                            AsyncImage(url: URL(string: recipe.photoUrlSmall ?? ""))
                                .frame(width: 150, height: 150)
                                .aspectRatio(contentMode: .fit)
                                .clipped()
                                .cornerRadius(8)
                            
                            VStack(spacing: 8) {
                                Text("Cuisine: \(recipe.cuisine)")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(recipe.name)
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .refreshable {
                        fetchAndSortRecipes()
                    }
                    .onAppear {
                        fetchAndSortRecipes()
                    }
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func fetchAndSortRecipes() {
        isLoading = true
        Task { @MainActor in
            recipes = try await NetworkManager.shared.fetchRecipes()
            recipes.sort {
                $0.cuisine < $1.cuisine
            }
            isLoading = false
        }
    }
}

#Preview {
    RecipeListView()
}
