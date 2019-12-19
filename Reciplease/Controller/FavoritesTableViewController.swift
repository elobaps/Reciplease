//
//  FavoritesTableViewController.swift
//  Reciplease
//
//  Created by Elodie-Anne Parquer on 05/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UIViewController {
    
    var coreDataManager: CoreDataManager?
    var recipeDetail: Recipe?
    var favoriteRecipe: FavoritesList?
    
    
    @IBOutlet weak var clearButton: UIBarButtonItem!
    @IBOutlet weak var favoriteTableView: UITableView! { didSet { favoriteTableView.tableFooterView = UIView() }}
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //guard segue.identifier == "segueToRecipeDetail" else { return }
        guard let recipeVC = segue.destination as? RecipeDetailViewController else { return }
        recipeVC.recipeDetail = self.recipeDetail
    }
    
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
        performSegue(withIdentifier: "segueToRecipeDetail", sender: self)
    }
}

// MARK: - UITableViewDelegate

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
