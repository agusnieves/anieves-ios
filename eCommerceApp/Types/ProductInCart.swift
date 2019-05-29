//
//  ProductInCart.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 5/28/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import ObjectMapper

class ProductInCart: NSObject, Mappable{
    
    
    var productId: Int?
    var productQuantity: Int?
    
    override init() {
        super.init()
    }
    
    init(prodId: Int, prodQty: Int) {
        self.productId = prodId
        self.productQuantity = prodQty
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.productId <- map["product_id"]
        self.productQuantity <- map["quantity"]
    }
    
}
