//
//  Recipe.swift
//  FetchRecipes
//
//  Created by Luis Puentes on 3/13/25.
//

import Foundation

struct Recipe: Decodable, Identifiable {
    var id: String
    var name: String
    var cuisine: String
    var photoUrlSmall: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photoUrlSmall = "photo_url_small"
    }
}

struct RecipeResponse: Decodable {
    var recipes: [Recipe]
    
    enum CodingKeys: String, CodingKey {
        case recipes
    }
}
