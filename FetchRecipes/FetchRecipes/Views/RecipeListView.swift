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
            ZStack {
                VStack {
                    if recipes.isEmpty && !isLoading {
                        GeometryReader { geo in
                            ScrollView {
                                EmptyListView()
                                    .frame(width: geo.size.width, height: geo.size.height)
                            }
                            .refreshable {
                                fetchRecipes()
                            }
                        }
                    } else {
                        List(recipes) { recipe in
                            RecipeRow(recipe: recipe)
                        }
                        .refreshable {
                            fetchRecipes()
                        }
                    }
                }
                .navigationTitle("Recipes")
                .navigationBarTitleDisplayMode(.large)
                .onAppear {
                    fetchRecipes()
                }
                
                LoaderView(isLoading: $isLoading)
            }
        }
    }
    
    private func fetchRecipes() {
        isLoading = true
        Task { @MainActor in
            recipes = try await NetworkManager.shared.fetchRecipes()
            sortRecipes()
            isLoading = false
        }
    }
    
    private func sortRecipes() {
        recipes.sort {
            $0.cuisine < $1.cuisine
        }
    }
}

#Preview {
    RecipeListView()
}
