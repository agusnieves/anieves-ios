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
    
    var image: UIImage
    var name: String
    var price: String
    
    init(image: UIImage, name: String, price: String){
        self.image = image
        self.name = name
        self.price = price
    }

}
