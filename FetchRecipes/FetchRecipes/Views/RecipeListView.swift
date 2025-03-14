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
                    .onAppear {
                        fetchRecipes()
                    }
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
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
