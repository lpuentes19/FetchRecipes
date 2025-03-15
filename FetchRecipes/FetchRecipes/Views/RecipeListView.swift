//
//  RecipeListView.swift
//  FetchRecipes
//
//  Created by Luis Puentes on 3/13/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var viewModel: RecipeListViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if viewModel.recipes.isEmpty && !viewModel.isLoading {
                        GeometryReader { geo in
                            ScrollView {
                                EmptyListView()
                                    .frame(width: geo.size.width, height: geo.size.height)
                            }
                            .refreshable { viewModel.getRecipes() }
                        }
                    } else {
                        List(viewModel.recipes) { recipe in
                            RecipeRow(recipe: recipe)
                        }
                        .refreshable { viewModel.getRecipes() }
                    }
                }
                .navigationTitle("Recipes")
                .navigationBarTitleDisplayMode(.large)
                .alert("Error",
                       isPresented: $viewModel.showAlert,
                       actions: {
                            Button("OK", role: .cancel, action: {})
                        }, message: {
                            Text(viewModel.errorMessage)
                        })
                .onAppear { viewModel.getRecipes() }
                
                LoaderView(isLoading: $viewModel.isLoading)
            }
        }
    }
}

#Preview {
    RecipeListView(viewModel: RecipeListViewModel(recipeService: RecipeService()))
}
