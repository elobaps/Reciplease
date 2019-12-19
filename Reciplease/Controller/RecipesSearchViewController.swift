//
//  RecipesSearchViewController.swift
//  Reciplease
//
//  Created by Elodie-Anne Parquer on 05/12/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import UIKit

class RecipesSearchViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView! { didSet { ingredientsTableView.tableFooterView = UIView() }}
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    var recipeService = RecipeService()
    var recipeData: RecipeData?
    var ingredients = [String]()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivityIndicator(shown: false)
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        addIngredient()
        ingredientsTableView.reloadData()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIBarButtonItem) {
        ingredients.removeAll()
        ingredientsTableView.reloadData()
    }
    
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        getRecipes()
    }
    
    // MARK: - Methods
    
    func toggleActivityIndicator(shown: Bool) {
        searchActivityIndicator.isHidden = !shown
        searchButton.isHidden = shown
    }
    
    func addIngredient() {
        guard let ingredientName = searchTextField.text else { return }
        if ingredientName.isBlank {
            presentAlert(titre: "Error", message: "Nothing to add to the list")
        } else {
            ingredients.append(ingredientName)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "segueToListRecipes" else { return }
        guard let recipesList = segue.destination as? RecipesTableViewController else { return }
        recipesList.recipeData = recipeData
        toggleActivityIndicator(shown: false)
    }
    
    func getRecipes() {
        if ingredients.isEmpty {
            presentAlert(titre: "Error", message: "Please enter 1 ingredients at least")
        } else {
            recipeService.getRecipes(ingredientList: ingredients.joined(separator: ",")) { result in
                switch result {
                case .success(let recipesData):
                        self.recipeData = recipesData
                        self.performSegue(withIdentifier: "segueToListRecipes", sender: nil)
                case .failure(let error):
                    self.presentAlert(titre: "Error", message: "Service unavailable")
                    print(error)
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension RecipesSearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredientsCell = tableView.dequeueReusableCell(withIdentifier: "IngredientsCell", for: indexPath)
        ingredientsCell.textLabel?.text = ingredients[indexPath.row]
        return ingredientsCell
    }
}

// MARK: - UITableViewDelegate

extension RecipesSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some ingredients in the list"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return ingredients.isEmpty ? 200 : 0
    }
}

// MARK: - UITextFieldDelegate

extension RecipesSearchViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}
