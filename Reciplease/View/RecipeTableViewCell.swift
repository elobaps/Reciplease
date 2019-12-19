//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Elodie-Anne Parquer on 06/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    @IBOutlet weak var recipeTimeLabel: UILabel!
    @IBOutlet weak var recipeScoreLabel: UILabel!
    
    var recipe: Hit? {
        didSet {
            guard let url = URL(string: recipe?.recipe.image ?? "recipe picture") else {return}
            recipeImageView.load(url: url)
            recipeNameLabel.text = recipe?.recipe.label
            recipeIngredientsLabel.text = recipe?.recipe.ingredients[0].text
            recipeTimeLabel.text = recipe?.recipe.totalTime.timeFormater()
            let score = recipe?.recipe.yield
            if score == 0 {
                recipeScoreLabel.text = "N/A"
            } else {
                recipeScoreLabel.text = "\(score ?? 0) people"
            }
        }
    }
    
    var favoriteRecipe: FavoritesList? {
        didSet {
            guard let image = favoriteRecipe?.image else { return }
            recipeImageView.image = UIImage(data: image)
            recipeNameLabel.text = favoriteRecipe?.name
            guard let ingredient = favoriteRecipe?.ingredients?.joined(separator: ",") else { return }
            recipeIngredientsLabel.text = "\(ingredient)"
            guard let time = Int(favoriteRecipe?.totalTime ?? "") else { return }
            recipeTimeLabel.text = "\(time.timeFormater())"
            let score = favoriteRecipe?.score
            if score == "" {
                recipeScoreLabel.text = "N/A"
            } else {
                recipeScoreLabel.text = "\(score ?? "") people"
            }
        }
    }
}
