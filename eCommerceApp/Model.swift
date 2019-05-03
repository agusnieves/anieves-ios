//
//  Model.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 5/2/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

class ModelManager{
    
    static let shared = ModelManager()
    
    var productsCart: [Int:Product] = [:]
    
    private init(){
    }
    
    func requestForCart(){
        //Code Process
    }
    
}
//ModelManager.shared.requestForCart()
