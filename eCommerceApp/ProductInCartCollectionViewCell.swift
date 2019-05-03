//
//  ProductInCartCollectionViewCell.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 5/2/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import UIKit

class ProductInCartCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    
    func setProductInCart(productInCart: Product) {
        productImage.image = productInCart.image
        productTitle.text = productInCart.name
        productPrice.text = "$" + String(productInCart.price)
        productQuantity.text = String(productInCart.quantity) + " units"
    }
}
