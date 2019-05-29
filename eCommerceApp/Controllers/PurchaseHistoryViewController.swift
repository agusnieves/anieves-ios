//
//  PurchaseHistoryViewController.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 5/27/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import UIKit

class PurchaseHistoryViewController: UIViewController {
    @IBOutlet weak var purchaseTableView: UITableView!
    var purchases: [Purchase] = ModelManager.shared.purchases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiModelManager.shared.getAllPurchases{ (purchases, error) in
            self.purchaseTableView.reloadData()
        }
        
        purchaseTableView.dataSource = self
        purchaseTableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ModelManager.shared.isCheckout = false
        ModelManager.shared.productsCart = setProductsToCart()
    }
    
    func setProductsToCart() -> [Int: Int]{
        var productsInPurchase: [Int:Int] = [:]
        let purchase: Purchase = purchases[(purchaseTableView.indexPathForSelectedRow?.row)!]
        for product in purchase.purchaseProduct ?? [] {
            productsInPurchase[product.productSold!.id!] = product.productQuantitySold
        }
        return productsInPurchase
    }
    
    @IBAction func viewPurchaseDetails(_ sender: Any) {
    }
}

extension PurchaseHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchase", for: indexPath) as! PurchaseTableViewCell
        cell.setPurchase(purchase: purchases[indexPath.row])
        return cell
    }
}
