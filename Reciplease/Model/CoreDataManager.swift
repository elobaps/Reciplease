//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Elodie-Anne Parquer on 16/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    // MARK: - Properties
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var favoritesRecipe: [FavoritesList] {
        let request: NSFetchRequest<FavoritesList> = FavoritesList.fetchRequest()
        guard let favorites = try? managedObjectContext.fetch(request) else { return [] }
        return favorites
    }
    
    // MARK: - Initializer
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    // MARK: - Manage Task Entity
    
    // swiftlint:disable:next function_parameter_count
    func addToFavoriteList(name: String, ingredients: [String], totalTime: String, score: String, recipeUrl: String, image: Data?) {
        let favorite = FavoritesList(context: managedObjectContext)
        favorite.name = name
        favorite.ingredients = ingredients
        favorite.totalTime = totalTime
        favorite.score = score
        favorite.recipeUrl = recipeUrl
        favorite.image = image
        coreDataStack.saveContext()
    }
    
    func deleteFromFavoriteList(name: String) {
        let request: NSFetchRequest<FavoritesList> = FavoritesList.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        guard let recipes = try? managedObjectContext.fetch(request) else { return }
        recipes.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    func deleteAllFavorites() {
        favoritesRecipe.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    func recipeIsAlreadyInFavorite(name: String) -> Bool {
        let request: NSFetchRequest<FavoritesList> = FavoritesList.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        guard let recipe = try? managedObjectContext.fetch(request) else { return false }
        if recipe.isEmpty { return false }
        return true
    }
}
