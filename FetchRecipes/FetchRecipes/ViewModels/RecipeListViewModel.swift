//
//  RecipeListViewModel.swift
//  FetchRecipes
//
//  Created by Luis Puentes on 3/14/25.
//

import Foundation

@MainActor
class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    
    let recipeService: RecipeServiceProtocol
    
    // MARK: - Init
    
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
    }
    
    // MARK: - Helpers
    
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
    
    // MARK: - API
    
    func fetchRecipes() async throws {
        do {
            recipes = try await recipeService.fetchRecipes()
            sortRecipes()
        } catch NetworkingError.invalidUrl {
            showError("Invalid URL for fetching recipes. Please contact customer service.")
        } catch NetworkingError.invalidStatusCode {
            showError("Something went wrong while fetching recipes. Please try again later.")
        } catch NetworkingError.requestFailed {
            showError("Failed trying to fetch recipes. Please try again later.")
        }
    }
    
    func getRecipes()  {
        isLoading = true
        Task {
            try await fetchRecipes()
            isLoading = false
        }
    }
}
