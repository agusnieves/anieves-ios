//
//  Purchase.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 5/26/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//
import Foundation
import UIKit
import ObjectMapper

class Purchase: NSObject, Mappable {
    
    var date: Date?
    var purchaseProduct: [PurchaseProduct]?
    var total: Int = 0
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.date <- (map["date"], CustomDateTransform())
        self.purchaseProduct <- map["products"]
        self.total = self.getTotal()
    }
    
    func getTotal() -> Int {
        var total = 0
        for productSold in self.purchaseProduct! {
            total += productSold.productSold!.price! + productSold.productQuantitySold!
        }
        return total
    }
}
