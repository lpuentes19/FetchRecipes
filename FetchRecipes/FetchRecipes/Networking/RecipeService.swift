//
//  RecipeService.swift
//  FetchRecipes
//
//  Created by Luis Puentes on 3/13/25.
//

import UIKit

protocol RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe]
}

enum NetworkingError: Error {
    case invalidUrl
    case invalidStatusCode
    case requestFailed
}

class RecipeService: RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe] {
        let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        guard let url = URL(string: urlString) else {
            throw NetworkingError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                throw NetworkingError.invalidStatusCode
            }
            
            guard (200...299).contains(statusCode) else {
                throw NetworkingError.invalidStatusCode
            }
            
            let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return recipeResponse.recipes
        } catch {
            throw NetworkingError.requestFailed
        }
    }
}
