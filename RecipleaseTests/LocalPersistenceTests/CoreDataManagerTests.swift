//
//  CoreDataManagerTests.swift
//  RecipleaseTests
//
//  Created by Elodie-Anne Parquer on 19/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

@testable import Reciplease
import XCTest

final class CoreDataManagerTests: XCTestCase {
    
    // MARK: - Properties
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    
    // MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }
    
    // MARK: - Tests
    
    func testAddRecipeMethod_WhenEntityIsCreated_ThenShouldedCorrectlySaved() {
        coreDataManager.addToFavoriteList(name: "Avocado Pesto", ingredients: [""], totalTime: "0", score: "2", recipeUrl: "https://food52.com/recipes/17892-avocado-pesto", image: Data())
        XCTAssertTrue(!coreDataManager.favoritesRecipe.isEmpty)
        XCTAssertTrue(coreDataManager.favoritesRecipe.count == 1)
        XCTAssertTrue(coreDataManager.favoritesRecipe[0].name! == "Avocado Pesto")
    }
    
    func testDeleteRecipeFromFavoriteMethod_WhenEntityIsDeleted_ThenShouldedCorrectlyDeleted() {
        coreDataManager.addToFavoriteList(name: "Avocado Pesto", ingredients: [""], totalTime: "0", score: "2", recipeUrl: "https://food52.com/recipes/17892-avocado-pesto", image: Data())
        coreDataManager.addToFavoriteList(name: "Easy Avocado Shake Recipe", ingredients: [""], totalTime: "0", score: "1", recipeUrl: "https://www.foodrepublic.com/recipes/easy-avocado-shake-recipe/", image: Data())
        coreDataManager.deleteFromFavoriteList(name: "Avocado Pesto")
        XCTAssertTrue(!coreDataManager.favoritesRecipe.isEmpty)
        XCTAssertTrue(coreDataManager.favoritesRecipe.count == 1)
        XCTAssertTrue(coreDataManager.favoritesRecipe[0].name! == "Easy Avocado Shake Recipe")
    }
    
    func testDeleteAllRecipesFromFavoriteMethod_WhenEntitiesAreDeleted_ThenShouldedCorrectlyDeleted() {
        coreDataManager.addToFavoriteList(name: "Avocado Pesto", ingredients: [""], totalTime: "0", score: "2", recipeUrl: "https://food52.com/recipes/17892-avocado-pesto", image: Data())
        coreDataManager.deleteAllFavorites()
        XCTAssertTrue(coreDataManager.favoritesRecipe.isEmpty)
    }
    
    func testRecipeIsAlreadyInFavoritesMethod_WhenEntityAlreadyExists_ThenShouldReturnTrue() {
        coreDataManager.addToFavoriteList(name: "Avocado Pesto", ingredients: [""], totalTime: "0", score: "2", recipeUrl: "https://food52.com/recipes/17892-avocado-pesto", image: Data())
        XCTAssertTrue(coreDataManager.recipeIsAlreadyInFavorite(name: "Avocado Pesto"))
    }
    
}
