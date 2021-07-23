//
//  AlcoholTypeApiProcessor.swift
//  Syntages
//
//  Created by Iliya dehsarvi on 7/21/21.
//

import Foundation

protocol IngredientApiDelegate {
	func didUpdateCocktailes(_ alcoholTypeApiProcessor: IngredientApiProcessor, ingredients: [Ingredient])
	func didFailWithError(error: Error)
}

struct IngredientApiProcessor {
	let ingredientTypeURL = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
	
	var delegate: IngredientApiDelegate?
	
	func fetchCocktails(alcoholName: String) {
		performRequest(with: ingredientTypeURL)
	}
		
	func performRequest(with urlString: String) {
		if let url = URL(string: urlString) {
			let session = URLSession(configuration: .default)
			let task = session.dataTask(with: url) { (data, response, error) in
				if error != nil {
					self.delegate?.didFailWithError(error: error!)
					return
				}
				if let safeData = data {
					if let ingredients = self.parseJSON(safeData) {
						self.delegate?.didUpdateCocktailes(self, ingredients: ingredients)
					}
				}
			}
			task.resume()
		}
	}
	
	func parseJSON(_ ingredientApiModel: Data) -> [Ingredient]? {
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(IngredientApiModel.self, from: ingredientApiModel)
			return decodedData.ingredients
		} catch {
			delegate?.didFailWithError(error: error)
			return nil
		}
	}
}
