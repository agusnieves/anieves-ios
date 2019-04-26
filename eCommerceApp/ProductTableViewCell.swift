//
//  ProductTableViewCell.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 4/20/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productAddButton: UIButton!
    weak var delegate: ProductTableViewCellDelegate?
    var indexPath: IndexPath?
    
    func setProduct(product: Product) {
        productImageView.image = product.image
        productTitle.text = product.name
        productPrice.text = product.price
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func productAddButtonAction(_ sender: UIButton) {
        if let index = indexPath {
            delegate?.productTableViewCellDidTapAdd(indexPath: index)
        } else {
            print("No index path")
        }
    }
}

protocol ProductTableViewCellDelegate : class {
    func productTableViewCellDidTapAdd(indexPath: IndexPath)
    func productTableViewCellDidTapPlus(_ sender: ProductTableViewCell)
    func productTableViewCellDidTapMinus(_ sender: ProductTableViewCell)
}
