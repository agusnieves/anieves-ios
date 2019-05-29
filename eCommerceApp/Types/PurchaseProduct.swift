//
//  PurchaseProduct.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 5/29/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import ObjectMapper

class PurchaseProduct: NSObject, Mappable {
    
    var productSold: Product?
    var productQuantitySold: Int?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.productSold <- map["product"]
        self.productQuantitySold <- map["quantity"]
    }
}
