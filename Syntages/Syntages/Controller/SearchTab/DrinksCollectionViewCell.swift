//
//  DrinksCollectionViewCell.swift
//  Syntages
//
//  Created by Iliya dehsarvi on 7/22/21.
//

import UIKit

class DrinksCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var cocktailImage: UIImageView!
	@IBOutlet weak var cocktailName: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		cocktailImage.layer.cornerRadius = 5
		cocktailImage.layer.masksToBounds = true
		cocktailImage.layer.borderWidth = 0.5
		cocktailImage.layer.borderColor = UIColor.darkGray.cgColor
	}
}
