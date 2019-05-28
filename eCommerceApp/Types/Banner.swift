//
//  Banner.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 4/20/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class Banner: NSObject, Mappable{
    
    
    var name: String?
    var note: String?
    var imageUrl: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        note <- map["description"]
        imageUrl <- map["photoUrl"]
    }
    
}
