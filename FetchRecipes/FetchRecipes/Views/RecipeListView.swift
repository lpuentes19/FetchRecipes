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
    @State var showAlert: Bool = false
    @State var errorMessage: String = ""
    
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
                .alert("Error",
                       isPresented: $showAlert,
                       actions: {
                            Button("OK", role: .cancel, action: {})
                        }, message: {
                            Text(errorMessage)
                        })
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
            defer { isLoading = false }
            do {
                recipes = try await NetworkManager.shared.fetchRecipes()
                sortRecipes()
                isLoading = false
            } catch NetworkingError.invalidUrl {
                showError("Invalid URL for fetching recipes. Please contact customer service.")
            } catch NetworkingError.invalidStatusCode {
                showError("Something went wrong while fetching recipes. Please try again later.")
            } catch NetworkingError.requestFailed {
                showError("Something went wrong while fetching recipes. Please try again later.")
            }
        }
    }
    
    private func sortRecipes() {
        recipes.sort {
            $0.cuisine < $1.cuisine
        }
    }
    
    private func showError(_ message: String) {
        showAlert = true
        errorMessage = message
        recipes = []
    }
}

#Preview {
    RecipeListView()
}
