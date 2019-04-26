//
//  ProductInCart.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 4/25/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import Foundation
import UIKit

class ProductInCart {
    
    var product: Product
    var quantity: Int
    
    init(product: Product, quantity: Int){
        self.product = product
        self.quantity = quantity
    }
    
}
