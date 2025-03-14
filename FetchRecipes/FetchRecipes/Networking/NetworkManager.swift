//
//  NetworkManager.swift
//  FetchRecipes
//
//  Created by Luis Puentes on 3/13/25.
//

import UIKit

enum NetworkingError: Error {
    case invalidUrl
    case invalidStatusCode
    case requestFailed
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
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
    
    func downloadPhoto(url: URL?) async -> UIImage? {
        guard let url = url else {
            return nil
        }
        
        do {
            if let cachedResponse = URLCache.shared.cachedResponse(for: .init(url: url)) {
                return UIImage(data: cachedResponse.data)
            } else {
                let (data, response) = try await URLSession.shared.data(from: url)
                URLCache.shared.storeCachedResponse(.init(response: response, data: data), for: .init(url: url))
                guard let image = UIImage(data: data) else {
                    return nil
                }
                
                return image
            }
        } catch {
            return nil
        }
    }
}
