//
//  RecipeRow.swift
//  FetchRecipes
//
//  Created by Luis Puentes on 3/14/25.
//

import SwiftUI

struct RecipeRow: View {
    @State var recipe: Recipe
    
    var body: some View {
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
}

#Preview {
    RecipeRow(recipe: Recipe(id: "", name: "Banana Pancakes", cuisine: "United States", photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"))
}
