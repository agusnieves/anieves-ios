//
//  PurchaseHistoryViewController.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 5/27/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import UIKit

class PurchaseHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var purchaseId: UILabel!
    @IBOutlet weak var purchaseDate: UILabel!
    @IBOutlet weak var purchaseTotal: UILabel!
    
    @IBOutlet weak var purchaseTableView: UITableView!
    var purchases: [Purchase] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiModelManager.shared.getAllPurchases{ (purchases, error) in
//            todo
        }
        
        purchaseTableView.dataSource = self
        purchaseTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "purchase", for: indexPath) as! PurchaseTableViewCell
        return cell
    }
    
    @IBAction func viewPurchaseDetails(_ sender: Any) {
    }
}

extension PurchaseHistoryViewController: PuchaseTableViewCellDelegate {
    
    func purchaseTableViewCellDidTapViewDetails(id: Int, indexPath: IndexPath) {
        <#code#>
    }
}
