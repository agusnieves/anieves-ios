//
//  Product.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 4/20/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import Foundation
import UIKit

class Product {
    
    var id: Int
    var image: UIImage
    var name: String
    var price: Int
    var quantity: Int
    
    init(id: Int, image: UIImage, name: String, price: Int){
        self.id = id
        self.image = image
        self.name = name
        self.price = price
        self.quantity = 0
    }

}
