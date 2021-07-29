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
		self.seachBar.delegate = self
		self.ingredientApiProcessor.delegate = self
		self.alcoholTypeApiProcessor.delegate = self
		self.ingredientApiProcessor.fetchIngredient()
		self.historyTableView.rowHeight = 649
		self.historyTableView.delegate = self
		self.historyTableView.dataSource = self
		self.historyTableView.reloadData()
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
		
		if let _drinks = self.drinks[self.ingredients[indexPath.row].strIngredient1] {
			let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsPreviewTableViewCellID", for: indexPath) as! IngredientsPreviewTableViewCell
//			print(self.ingredients[indexPath.row].strIngredient1, _drinks.count)
			if _drinks.count != 0 {
				print(self.ingredients[indexPath.row].strIngredient1, _drinks.count)
				cell.drinks = _drinks
				cell.ingredientName.text = self.ingredients[indexPath.row].strIngredient1
				cell.cocktailName.text = _drinks[0].strDrink
				
				switch _drinks.count {
				case 1:
					cell.previewPageView.numberOfPages = 1
					
					if let stringURL = URL(string: _drinks[0].strDrinkThumb) {
						cell.cocktailImage1.load(url: stringURL)
					}
					break
				case 2:
					cell.previewPageView.numberOfPages = 2

					if let stringURL = URL(string: _drinks[0].strDrinkThumb) {
						cell.cocktailImage1.load(url: stringURL)
					}
					if let stringURL = URL(string: _drinks[1].strDrinkThumb) {
						cell.cocktailImage2.load(url: stringURL)
					}
					break
				default:
					if let stringURL = URL(string: _drinks[0].strDrinkThumb) {
						cell.cocktailImage1.load(url: stringURL)
					}
					if let stringURL = URL(string: _drinks[1].strDrinkThumb) {
						cell.cocktailImage2.load(url: stringURL)
					}
					if let stringURL = URL(string: _drinks[2].strDrinkThumb) {
						cell.cocktailImage3.load(url: stringURL)
					}
				}
				
				if let stringURL = URL(string: ingredientsImageURL+ingredients[indexPath.row].strIngredient1+".png") {
					cell.inegredientImage.load(url: stringURL)
//					cell.inegredientImage.text 
				}
//				cell.tempLoading.startAnimating()
//				if let stringURL = URL(string: _drinks[0].strDrinkThumb) {
//					cell.cocktailImage1.load(url: stringURL)
//				}
//				if let stringURL = URL(string: _drinks[1].strDrinkThumb) {
//					cell.cocktailImage2.load(url: stringURL)
//				}
//				if let stringURL = URL(string: _drinks[2].strDrinkThumb) {
//					cell.cocktailImage3.load(url: stringURL)
//				}
//
			}
			return cell
		}
//		let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as! UITableViewCell

//		cell.cocktailName.text =
		
//		cell.drinks = self.drinks[ingredients[indexPath.row].strIngredient1] ?? []
//		
//		if cell.drinks.count > 3 {
//			cell.ingredientName.text = ingredients[indexPath.row].strIngredient1
//			if let stringURL = URL(string: ingredientsImageURL+ingredients[indexPath.row].strIngredient1+".png") {
//				cell.inegredientImage.load(url: stringURL)
//			}
//			cell.tempLoading.startAnimating()
//			if let stringURL = URL(string: drinks[ingredients[indexPath.row].strIngredient1]?[0].strDrinkThumb ?? "") {
//				cell.cocktailImage1.load(url: stringURL)
//			}
//			if let stringURL = URL(string: drinks[ingredients[indexPath.row].strIngredient1]?[1].strDrinkThumb ?? "") {
//				cell.cocktailImage2.load(url: stringURL)
//			}
//			if let stringURL = URL(string: drinks[ingredients[indexPath.row].strIngredient1]?[2].strDrinkThumb ?? "") {
//				cell.cocktailImage3.load(url: stringURL)
//			}
//		}
		return UITableViewCell()
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
	}
}
//MARK: - IngredientApiDelegate
extension SearchViewController: IngredientApiDelegate {
	func didUpdateIngredient(_ alcoholTypeApiProcessor: IngredientApiProcessor, ingredients : [Ingredient]) {
		DispatchQueue.main.async {
			self.ingredients = ingredients
			for ingredient in self.ingredients {
//				print(ingredient.strIngredient1)
				self.alcoholTypeApiProcessor.fetchCocktails(alcoholName: ingredient.strIngredient1)
			}
			self.historyTableView.reloadData()
		}
	}

	func didFailWithError(error: Error) {
		DispatchQueue.main.async {
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
			if drinks.count > 3 {
//				print(inegridient, drinks.count)
			}
			self.drinks[inegridient] = drinks
		}
	}
}
