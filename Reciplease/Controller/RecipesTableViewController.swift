//
//  RecipesTableViewController.swift
//  Reciplease
//
//  Created by Elodie-Anne Parquer on 05/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import UIKit

class RecipesTableViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Propertie
    
    var recipeDetail: Recipe?
    var recipeData: RecipeData?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //guard segue.identifier == "segueToRecipeDetail" else { return }
        guard let recipeVC = segue.destination as? RecipeDetailViewController else { return }
        recipeVC.recipeDetail = self.recipeDetail
    }
}


// MARK: - UITableViewDataSource

extension RecipesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeData?.hits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            fatalError("Cell can't be loaded")
        }
        cell.recipe = recipeData?.hits[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeDetail = recipeData?.hits[indexPath.row].recipe
        performSegue(withIdentifier: "segueToRecipeDetail", sender: self)
    }
}

// MARK: - UITableViewDelegate

extension RecipesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // cell's height
        return 186
    }
}
