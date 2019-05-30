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
    var clickedCellIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiModelManager.shared.getAllPurchases{ (purchases, error) in
            self.purchaseTableView.reloadData()
        }
        
        purchaseTableView.dataSource = self
        purchaseTableView.delegate = self
    }
    
    func setProductsToCart() -> [Int: Int]{
        var productsInPurchase: [Int:Int] = [:]
        let purchase: Purchase = purchases[clickedCellIndexPath?.row ?? 0]
        for product in purchase.purchaseProduct ?? [] {
            productsInPurchase[product.productSold!.id!] = product.productQuantitySold
        }
        return productsInPurchase
    }
}

extension PurchaseHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchase", for: indexPath) as! PurchaseTableViewCell
        cell.indexPath = indexPath
        cell.delegate = self
        cell.setPurchase(purchase: purchases[indexPath.row], id: indexPath.row)
        return cell
    }
}

extension PurchaseHistoryViewController: PurchaseTableViewCellDelegate {
    
    func purchaseTableViewCellDidTapViewDetails(indexPath: IndexPath) {
        ModelManager.shared.isCheckout = false
        clickedCellIndexPath = indexPath
        ModelManager.shared.productsCart = setProductsToCart()
        self.performSegue(withIdentifier: "goToDetails", sender:  self)
    }
    
}
