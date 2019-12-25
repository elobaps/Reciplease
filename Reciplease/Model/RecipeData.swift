//
//  RecipeData.swift
//  Reciplease
//
//  Created by Elodie-Anne Parquer on 05/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

// MARK: - RecipeData
struct RecipeData: Decodable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Int
    let dietLabels, healthLabels: [String]
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, totalWeight: Double
    let totalTime: Int
    let totalNutrients, totalDaily: [String: Total]
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case iu = "IU"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

// MARK: - Ingredient
struct Ingredient: Decodable {
    let text: String
    let weight: Double
}

// MARK: - Total
struct Total: Decodable {
    let label: String
    let quantity: Double
    let unit: Unit
}
