//
//  Product.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 4/20/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class Product: NSObject, Mappable {
    
    var id: Int?
    var imageUrl: String?
    var name: String?
    var price: Int?
    var cat: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        price <- map["price"]
        cat <- map["category"]
        imageUrl <- map["photoUrl"]
    }
}
