//
//  IngredientsApiModel.swift
//  Syntages
//
//  Created by Iliya dehsarvi on 7/22/21.
//

import Foundation

// MARK: - IngredientApiModel
struct IngredientApiModel: Codable {
    let drinks: [Ingredient]
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let strIngredient1: String
}
