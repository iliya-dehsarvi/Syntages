//
//  IngredientsTableViewCell.swift
//  Syntages
//
//  Created by Iliya dehsarvi on 7/22/21.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
	
	@IBOutlet weak var imageBackground: UIView!
	@IBOutlet weak var ingredientName: UILabel!
	@IBOutlet weak var drinkSuggestionsCollectionView: UICollectionView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		imageBackground.layer.cornerRadius = 20
		imageBackground.layer.masksToBounds = true
		drinkSuggestionsCollectionView.delegate = self
		drinkSuggestionsCollectionView.dataSource = self
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	@IBAction func seeAllTapped(_ sender: UIButton) {
		print("See All button was tapped for\(ingredientName.text!)")
	}
}

// - MARK:
extension IngredientsTableViewCell: UICollectionViewDelegate {
	
}

extension IngredientsTableViewCell: UICollectionViewDataSource {
	
}

