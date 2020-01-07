//
//  FavoritesTableViewController.swift
//  Reciplease
//
//  Created by Elodie-Anne Parquer on 05/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var clearButton: UIBarButtonItem!
    @IBOutlet weak var favoriteTableView: UITableView! { didSet { favoriteTableView.tableFooterView = UIView() }}
    
    // MARK: - Properties
    
    var coreDataManager: CoreDataManager?
    var recipeDetail: Recipe?
    var favoriteRecipe: FavoritesList?
    var recipeRepresentable: RecipeRepresentable?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
    }
    
    override func viewWillAppear(_ animated: Bool) {
          favoriteTableView.reloadData()
      }
    
    // MARK: - Method
    
    /// method that sends the data to RecipesDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeVC = segue.destination as? RecipeDetailViewController else { return }
        recipeVC.recipeRepresentable = recipeRepresentable
    }
    
    // MARK: - Action
    
    /// method which removes all favorites
    @IBAction func clearButtonTapped(_ sender: Any) {
        coreDataManager?.deleteAllFavorites()
        favoriteTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension FavoritesTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coreDataManager?.favoritesRecipe.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        favoriteCell.favoriteRecipe = coreDataManager?.favoritesRecipe[indexPath.row]
        return favoriteCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteRecipe = coreDataManager?.favoritesRecipe[indexPath.row]
        recipeRepresentable = RecipeRepresentable(name: favoriteRecipe?.name ?? "", imageData: favoriteRecipe?.image, ingredients: favoriteRecipe?.ingredients ?? [], url: favoriteRecipe?.recipeUrl ?? "", score: favoriteRecipe?.score ?? "N/A", totalTime: favoriteRecipe?.totalTime ?? "")
        performSegue(withIdentifier: "segueToRecipeDetail", sender: self)
    }
}

// MARK: - UITableViewDelegate

/// extension that manages the table view and allows the display of a message when the list is empty and the deletion of a cell
extension FavoritesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            guard let recipe = coreDataManager?.favoritesRecipe[indexPath.row].name else { return }
            coreDataManager?.deleteFromFavoriteList(name: recipe)
            favoriteTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some recipe in your Favorites"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager?.favoritesRecipe.isEmpty ?? true ? 200 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // cell's height
        return 186
    }
}
