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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.productImage.layer.cornerRadius = CGFloat(roundf(Float(self.productImage.frame.size.width / 20.0)))
    }

    func setProductInCart(productInCart: Product) {
        if let imageUrl = productInCart.imageUrl {
            productImage.kf.setImage(with: URL(string: imageUrl))
        }
        else {
            self.productImage.image = #imageLiteral(resourceName: "noimage")
        }
        productTitle.text = productInCart.name
        if let prodPrice = productInCart.price {
            self.productPrice.text = "$" + String(prodPrice)
        }
        if let prodQuantity = ModelManager.shared.productsCart[productInCart.id!] {
            self.productQuantity.text = String(prodQuantity) + " units"

        }
    }
}
