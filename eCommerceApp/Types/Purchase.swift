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
    var products: [Product]?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.date <- map["date"]
        self.products <- map["products"]
    }
}
