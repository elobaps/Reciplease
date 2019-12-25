//
//  RecipeRepresentable.swift
//  Reciplease
//
//  Created by Elodie-Anne Parquer on 20/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

struct RecipeRepresentable {
    let name: String
    let imageData: Data?
    let ingredients: [String]
    let url: String
    let score: String
    let totalTime: String
}
