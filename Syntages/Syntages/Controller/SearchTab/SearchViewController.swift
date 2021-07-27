//
//  SearchViewController.swift
//  Syntages
//
//  Created by Iliya dehsarvi on 7/19/21.
//

import UIKit

//MARK: - SearchViewController
class SearchViewController: UIViewController {
	//MARK: - @IBOutlets
	@IBOutlet weak var historyTableView: UITableView!
	@IBOutlet weak var seachBar: UISearchBar!
	//MARK: - Variables
	var ingredientApiProcessor = IngredientApiProcessor()
	var alcoholTypeApiProcessor = AlcoholTypeApiProcessor()

	var ingredients: [Ingredient] = []
	var drinks: [String: [Drink]] = [:]
	
	let ingredientsImageURL = "https://www.thecocktaildb.com/images/ingredients/"
	//	var searchHistory: [Drink] = []
	//MARK: - Methods
	override func viewDidLoad() {
		super.viewDidLoad()

		self.historyTableView.register(UINib(nibName: "IngredientsPreviewTableViewCell", bundle: nil), forCellReuseIdentifier: "IngredientsPreviewTableViewCellID")
		self.historyTableView.delegate = self
		self.historyTableView.dataSource = self
		self.seachBar.delegate = self
		self.ingredientApiProcessor.delegate = self
		self.ingredientApiProcessor.fetchIngredient()
		self.alcoholTypeApiProcessor.delegate = self
		self.historyTableView.rowHeight = 649
	}
}
//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate { }
//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.ingredients.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsPreviewTableViewCellID", for: indexPath) as! IngredientsPreviewTableViewCell
		self.alcoholTypeApiProcessor.fetchCocktails(alcoholName: ingredients[indexPath.row].strIngredient1)
		
//		if let alcoholKey = ingredients[indexPath.row].strIngredient1 {
//			cell.drinks = self.drinks[alcoholKey]
//		}
		
		
		cell.drinks = self.drinks[ingredients[indexPath.row].strIngredient1] ?? []
		
		
		print("Search: ", cell.drinks.count)
		
		cell.ingredientName.text = ingredients[indexPath.row].strIngredient1
		
//		cell.ingredientName.text = ingredients[indexPath.row].strIngredient1
		if let stringURL = URL(string: ingredientsImageURL+ingredients[indexPath.row].strIngredient1+".png") {
			cell.inegredientImage.load(url: stringURL)
		}


		cell.tempLoading.startAnimating()
		
		if drinks.count > 3 {
			if let stringURL = URL(string: drinks[ingredients[indexPath.row].strIngredient1]?[0].strDrinkThumb ?? "") {
				cell.cocktailImage1.load(url: stringURL)
			}
			if let stringURL = URL(string: drinks[ingredients[indexPath.row].strIngredient1]?[1].strDrinkThumb ?? "") {
				cell.cocktailImage2.load(url: stringURL)
			}
			if let stringURL = URL(string: drinks[ingredients[indexPath.row].strIngredient1]?[2].strDrinkThumb ?? "") {
				cell.cocktailImage3.load(url: stringURL)
			}
		}
		
		
//		cell.setupScreens()
//		cell.alcoholTypeApiProcessor.fetchCocktails(alcoholName: ingredients[indexPath.row].strIngredient1)
		
		
		
		//		cell.textLabel?.text = ingredients[indexPath.row].strDrink
		//			if let stringURL = URL(string: ingredients[indexPath.row].strDrinkThumb) {
		//				cell.imageView?.load(url: stringURL)
		//				cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.size.width ?? 0.0) / 2
		//				cell.imageView?.layer.masksToBounds = true
		//			}
		
		return cell
	}
}
//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		//		self.ingredients = self.searchHistory.reversed()
		self.historyTableView.reloadData()
	}
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		//		print(searchBar.text!)
		//		if let alcoholType = searchBar.text {
		//			self.alcoholTypeApiProcessor.fetchCocktails(alcoholName: alcoholType)
		//			let lastSearchEntry = Drink(strDrink: alcoholType, strDrinkThumb: "", idDrink: "")
		//			self.searchHistory.append(lastSearchEntry)
		//		}
		searchBar.endEditing(true)
		self.historyTableView.reloadData()

		//		print(drinks.count)
		//		self.historyTableView.reloadData()
	}
}

//MARK: - IngredientApiDelegate
extension SearchViewController: IngredientApiDelegate {
	func didUpdateIngredient(_ alcoholTypeApiProcessor: IngredientApiProcessor, ingredients : [Ingredient]) {
		DispatchQueue.main.async {
			self.ingredients = ingredients
			
//			for i in ingredients {
//				print(i)
//			}
			self.historyTableView.reloadData()
		}
	}

	func didFailWithError(error: Error) {
		DispatchQueue.main.async {
//			let drink = Drink(strDrink: "No results found.", strDrinkThumb: "", idDrink: "")
//			self.drinks = [drink]
//			self.historyTableView.reloadData()
			print(error)

		}
	}
}

//MARK: - load method for UIImageView
extension UIImageView {
	func load(url: URL) {
		DispatchQueue.global().async { [weak self] in
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						self?.image = image
					}
				}
			}
		}
	}
}


//MARK: - AlcoholTypeDrinksDelegate
extension SearchViewController: AlcoholTypeDrinksDelegate {
	func didUpdateCocktailes(_ alcoholTypeApiProcessor: AlcoholTypeApiProcessor, drinks: [Drink], inegridient: String) {
		DispatchQueue.main.async {
//			print(drinks.count)
			self.drinks[inegridient] = drinks
		}
	}
	
//	func didFailWithError(error: Error) {
//		DispatchQueue.main.async {
//			print(error)
//		}
//	}
}
