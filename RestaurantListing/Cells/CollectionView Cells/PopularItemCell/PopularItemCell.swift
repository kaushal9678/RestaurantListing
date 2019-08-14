//
//  PopularItemCell.swift
//  eZnetOrder
//
//  Created by Kaushal on 22/04/19.
//  Copyright © 2019 kaushlendra. All rights reserved.
//

import UIKit

class PopularItemCell: UICollectionViewCell {
	
	@IBOutlet weak var itemImage: UIImageView!
	
	@IBOutlet weak var labelTitle: UILabel!

	@IBOutlet weak var labelTime: UILabel!
	
	@IBOutlet weak var labelSubtitle: UILabel!
	
	@IBOutlet weak var labelPrice: UILabel!
	
	@IBOutlet weak var labelRestaurantName: UILabel!
	
	@IBOutlet weak var labelRating: UILabel!
	
	@IBOutlet weak var labelTotalReviews: UILabel!
}
