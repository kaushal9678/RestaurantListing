//
//  MenuItemListingCell.swift
//  eZnetOrder
//
//  Created by Kaushal on 22/04/19.
//  Copyright © 2019 kaushlendra. All rights reserved.
//

import UIKit

class MenuItemListingCell: UITableViewCell {

	@IBOutlet weak var categoriesCollectionView: UICollectionView!
	
	var arrayOfMenuItems:[[String:AnyObject]]? = nil
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension MenuItemListingCell: UICollectionViewDataSource, UICollectionViewDelegate{
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.arrayOfMenuItems?.count ?? 0;
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewcell.kCategoriesItemCell, for: indexPath)as! CategoriesItemCell
		let object = self.arrayOfMenuItems?[indexPath.item]
		
		cell.viewImgContainer.layer.shadowColor = UIColor.black.cgColor
		cell.viewImgContainer.layer.shadowOpacity = 10
		cell.viewImgContainer.layer.shadowOffset = CGSize.init(width: 4, height: 5) //CGSize.zero
		cell.viewImgContainer.layer.shadowRadius = 10
		let imageURl = object?["product_image"] as! String ?? "http://www.inimco.com/wp-content/themes/consultix/images/no-image-found-360x260.png"
		
		cell.viewProductImage.load(url: URL.init(string: imageURl)!)
		
		
		cell.labelTitle.text = object?["name"] as?  String ;
		
		
		return cell;
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1;
	}
}

