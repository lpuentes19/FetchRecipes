//
//  RecipeListViewModelTests.swift
//  RecipeListViewModelTests
//
//  Created by Luis Puentes on 3/13/25.
//

import XCTest
@testable import FetchRecipes

final class RecipeListViewModelTests: XCTestCase {
    var mockService: MockRecipeService!
    var viewModel: RecipeListViewModel!

    @MainActor
    override func setUp(){
        super.setUp()
        mockService = MockRecipeService()
        viewModel = RecipeListViewModel(recipeService: mockService)
    }

    override func tearDown() {
        super.tearDown()
        mockService = nil
        viewModel = nil
    }
    
    // MARK: Tests
    
    @MainActor
    func testFetchRecipesSuccess() async throws {
        mockService.recipes = [Recipe(id: "1", name: "Banana Pancake", cuisine: "American"),
                               Recipe(id: "2", name: "Chili Dog", cuisine: "American"),
                               Recipe(id: "3", name: "Sloppy Joe", cuisine: "American")]
        try await viewModel.fetchRecipes()
        
        XCTAssertTrue(viewModel.recipes.count > 0)
    }
    
    @MainActor
    func testFetchRecipesFailureInvalidUrl() async throws {
        mockService.errorToThrow = NetworkingError.invalidUrl
        try await viewModel.fetchRecipes()
        
        XCTAssertEqual(viewModel.errorMessage, "Invalid URL for fetching recipes. Please contact customer service.")
    }
    
    @MainActor
    func testFetchRecipesFailureInvalidStatusCode() async throws {
        mockService.errorToThrow = NetworkingError.invalidStatusCode
        try await viewModel.fetchRecipes()
        
        XCTAssertEqual(viewModel.errorMessage, "Something went wrong while fetching recipes. Please try again later.")
    }
    
    @MainActor
    func testFetchRecipesFailureRequestFailed() async throws {
        mockService.errorToThrow = NetworkingError.requestFailed
        try await viewModel.fetchRecipes()
        
        XCTAssertEqual(viewModel.errorMessage, "Failed trying to fetch recipes. Please try again later.")
    }
    
    @MainActor
    func testSortingRecipesByCuisine() async throws {
        mockService.recipes = [Recipe(id: "1", name: "Pasta", cuisine: "Italian"),
                               Recipe(id: "2", name: "Escargo", cuisine: "French"),
                               Recipe(id: "3", name: "Sloppy Joe", cuisine: "American")]
        try await viewModel.fetchRecipes()
        
        XCTAssertEqual(viewModel.recipes.first?.cuisine, "American")
    }
}
