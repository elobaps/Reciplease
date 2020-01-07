//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Elodie-Anne Parquer on 05/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeTimeLabel: UILabel!
    @IBOutlet weak var recipeScoreLabel: UILabel!
    @IBOutlet weak var directionsButton: UIButton!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var recipeTableView: UITableView!
    
    // MARK: - Properties
    
    private var coreDataManager: CoreDataManager?
    var recipeRepresentable: RecipeRepresentable?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        updateRecipe()
    }
    
    /// method which reloads the favorite button to inform the user if the recipe is already in his favorites
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if coreDataManager?.recipeIsAlreadyInFavorite(name: recipeTitleLabel.text ?? "") == false {
            favoriteButton.image = UIImage(named: "icon-star")
        } else {
            favoriteButton.image = UIImage(named: "icon-fullstar")
        }
    }
    
    // MARK: - Methods
    
    func updateRecipe() {
        guard let recipeRepresentable = recipeRepresentable else { return }
        recipeTitleLabel.text = recipeRepresentable.name
        recipeTimeLabel.text = recipeRepresentable.totalTime
        if recipeRepresentable.score == "0" {
            recipeScoreLabel.text = "N/A"
        } else {
            recipeScoreLabel.text = "\(recipeRepresentable.score) people"
        }
        guard let image = recipeRepresentable.imageData else { return }
        recipeImageView.image = UIImage(data: image)
    }
    
    func addRecipeToFavorite() {
        guard let recipeRepresentable = recipeRepresentable else { return }
        coreDataManager?.addToFavoriteList(name: recipeRepresentable.name, ingredients: recipeRepresentable.ingredients, totalTime: recipeRepresentable.totalTime, score: recipeRepresentable.score, recipeUrl: recipeRepresentable.url, image: recipeRepresentable.imageData)
    }
    
    func deleteRecipeFromFavorites() {
        coreDataManager?.deleteFromFavoriteList(name: recipeTitleLabel.text ?? "")
    }
    
    @IBAction func getDirectionsButtonTapped(_ sender: Any) {
        guard let url = URL(string: recipeRepresentable?.url ?? "") else {return}
        UIApplication.shared.open(url)
    }
    
    /// method that saves the user's choice if he decides to add the recipe to his favorites
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        if coreDataManager?.recipeIsAlreadyInFavorite(name: recipeTitleLabel.text ?? "") == true {
            deleteRecipeFromFavorites()
            favoriteButton.image = UIImage(named: "icon-star")
        } else {
            addRecipeToFavorite()
            favoriteButton.image = UIImage(named: "icon-fullstar")
        }
    }
}

// MARK: - UITableViewDataSource

extension RecipeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeRepresentable?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) 
        guard let recipeRepresentable = recipeRepresentable else { return UITableViewCell() }
        let ingredient = recipeRepresentable.ingredients[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }
}
