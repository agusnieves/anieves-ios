//
//  ProductTableViewCell.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 4/20/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productAddButton: UIButton!
    @IBOutlet weak var productPlusButton: UIButton!
    @IBOutlet weak var productMinusButton: UIButton!
    weak var delegate: ProductTableViewCellDelegate?
    var indexPath: IndexPath?
    var isInCart: Bool = false
    var productId: Int?
    
    func setProduct(product: Product) {
        productImageView.image = product.image
        productTitle.text = product.name
        productPrice.text = "$" + String(product.price)
        productId = product.id
    }
    
    override func layoutSubviews() {
        if(isInCart) {
            productAddButton.isHidden = true
            productPlusButton.isHidden = false
            productMinusButton.isHidden = false
            productQuantity.isHidden = false
        } else {
            productAddButton.isHidden = false
            productPlusButton.isHidden = true
            productMinusButton.isHidden = true
            productQuantity.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func productAddButtonAction(_ sender: UIButton) {
        if let index = indexPath {
            delegate?.productTableViewCellDidTapAdd(id: productId!,indexPath: index)
        } else {
            print("No index path")
        }
    }
    @IBAction func productPlusButtonAction(_ sender: UIButton) {
        print("Sube")
    }
    
    @IBAction func productMinusButtonAction(_ sender: UIButton) {
        print("Baja")
    }
}

protocol ProductTableViewCellDelegate : class {
    func productTableViewCellDidTapAdd(id: Int, indexPath: IndexPath)
    func productTableViewCellDidTapPlus(id: Int,indexPath: IndexPath)
    func productTableViewCellDidTapMinus(id: Int,indexPath: IndexPath)
}
