//
//  PurchaseTableViewCell.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 5/28/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import UIKit

class PurchaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

protocol PuchaseTableViewCellDelegate : class {
    func purchaseTableViewCellDidTapViewDetails(id: Int, indexPath: IndexPath)
}
