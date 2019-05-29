//
//  PurchaseTableViewCell.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 5/28/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import UIKit

class PurchaseTableViewCell: UITableViewCell {

    @IBOutlet weak var purchaseId: UILabel!
    @IBOutlet weak var purchaseDate: UILabel!
    @IBOutlet weak var purchaseTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setPurchase(purchase: Purchase) {
        self.purchaseId.text = "Purchase #" + String(Int.random(in: 1...10))
        self.purchaseDate.text = formatDate(date: purchase.date!)
        self.purchaseTotal.text = "$ " + String(purchase.total)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
}
