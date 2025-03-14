//
//  FetchRecipesApp.swift
//  FetchRecipes
//
//  Created by Luis Puentes on 3/13/25.
//

import SwiftUI

@main
struct FetchRecipesApp: App {
    var body: some Scene {
        WindowGroup {
            let recipeService = RecipeService()
            let viewModel = RecipeListViewModel(recipeService: recipeService)
            RecipeListView(viewModel: viewModel)
        }
    }
}
