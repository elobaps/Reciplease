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
    
    var recipeService = RecipeService()
    var recipeData: RecipeData?
    var ingredients = [String]()
    var recipeDetail: Recipe?
    private var coreDataManager: CoreDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        updateRecipe()
    }
    
    func updateRecipe() {
        guard let recipeDetail = recipeDetail else { return }
        guard let url = URL(string: recipeDetail.image) else {return}
        recipeImageView.load(url: url)
        recipeTitleLabel.text = recipeDetail.label
        recipeTimeLabel.text = recipeDetail.totalTime.timeFormater()
        let score = recipeDetail.yield
        if score == 0 {
            recipeScoreLabel.text = "N/A"
        } else {
            recipeScoreLabel.text = "\(score) people"
        }
    }
    
    func addRecipeToFavorite() {
        coreDataManager?.addToFavoriteList(name: recipeDetail?.label ?? "", ingredients: recipeDetail?.ingredients.map { $0.text } ?? [], totalTime: recipeDetail?.totalTime.timeFormater() ?? "", score: String(recipeDetail?.yield ?? 0), recipeUrl: recipeDetail?.url ?? "", image: recipeDetail?.image.data)
    }
    
    func deleteRecipeFromFavorites() {
        coreDataManager?.deleteFromFavoriteList(name: recipeTitleLabel.text ?? "")
//        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getDirectionsButtonTapped(_ sender: Any) {
        guard let url = URL(string: recipeDetail?.url ?? "") else {return}
        UIApplication.shared.open(url)
    }
    
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
        return recipeDetail?.ingredientLines.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) 
        // cell.recipe = recipeDetail?.ingredientLines[indexPath.row]
        guard let recipeDetails = recipeDetail else { return UITableViewCell() }
        let ingredient = recipeDetails.ingredientLines[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }
}
