//
//  Model.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 5/2/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

class ModelManager{
    
    static let shared = ModelManager()
    var banners: [Banner] = []
    var products: [Product] = []
    var productsById: [Int:Product] = [:]
    var productsCart: [Int:Int] = [:]
    var purchases: [Purchase] = []
    var isCheckout: Bool = true
    
    private init(){
    }
    
    func changeItemQuantity(key: Int, number: Int){
        productsCart[key] = number
        self.productsCart = self.productsCart.filter{$0.value > 0}
    }
    
    func fillProductsById(products: [Product]){
        for product in products {
            if (productsById[product.id!] == nil){
                productsById[product.id!] = product
            }
        }
    }
}
//ModelManager.shared.requestForCart()
