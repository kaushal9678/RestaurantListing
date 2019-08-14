//
//  PopularItemTableViewCell.swift
//  eZnetOrder
//
//  Created by Kaushal on 22/04/19.
//  Copyright © 2019 kaushlendra. All rights reserved.
//

import UIKit
import AlamofireImage
class PopularItemTableViewCell: UITableViewCell {

	
	@IBOutlet weak var popularItem_collectionView: UICollectionView!
	var arrayOfPopularItems:[[String:AnyObject]]? = nil
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension PopularItemTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.arrayOfPopularItems?.count ?? 0;
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
	 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewcell.kPopularItemCell, for: indexPath)as! PopularItemCell
		let object = self.arrayOfPopularItems?[indexPath.item]
		
		let imageURl = object?["product_image"] as! String ?? "http://www.inimco.com/wp-content/themes/consultix/images/no-image-found-360x260.png"
		cell.itemImage.load(url: URL.init(string: imageURl)!)
		
	
		cell.labelTitle.text = object?["name"] as?  String ;
		cell.labelRating.text = object?["ratings"]as? String;
		cell.labelTime.text  = object?["time"]as? String;
		let reviews = object?["totalReviews"] as? String
		cell.labelTotalReviews.text =  reviews! + "reviews";
		cell.labelSubtitle.text = object?["restaurant_location"] as? String;
		cell.labelPrice.text = object?["price"] as? String;
		cell.labelRestaurantName.text =  object?["restaurant_name"] as? String;
		//cell.labelPrice.text = object?["price"] as? String;
		//cell.labelPrice.text = object?["price"] as? String;
		
		return cell;
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1;
	}
}

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
