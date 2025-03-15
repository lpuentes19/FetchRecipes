//
//  MockRecipeService.swift
//  FetchRecipesTests
//
//  Created by Luis Puentes on 3/14/25.
//

import Foundation
@testable import FetchRecipes

class MockRecipeService: RecipeServiceProtocol {
    var recipes: [Recipe] = []
    var errorToThrow: NetworkingError?
    
    func fetchRecipes() async throws -> [Recipe] {
        if let error = errorToThrow {
            throw error
        }
        
        return recipes
    }
}
