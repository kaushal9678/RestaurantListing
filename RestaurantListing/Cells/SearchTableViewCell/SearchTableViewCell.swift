//
//  SearchTableViewCell.swift
//  eZnetOrder
//
//  Created by Kaushal on 22/04/19.
//  Copyright © 2019 kaushlendra. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

	
	//MARK: cell IBOutlets
	
	@IBOutlet weak var viewContainer: UIView!
	
	@IBOutlet weak var viewSearchBar: UISearchBar!
	
	
	override func awakeFromNib() {
		
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
