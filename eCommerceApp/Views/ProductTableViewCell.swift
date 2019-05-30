//
//  ProductTableViewCell.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 4/20/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import UIKit
import Kingfisher

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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.productImageView.layer.cornerRadius = CGFloat(roundf(Float(self.productImageView.frame.size.width / 2.0)))
        self.productAddButton.layer.cornerRadius = CGFloat(roundf(Float(self.productAddButton.frame.size.height / 2.0)))
        self.productAddButton.layer.borderWidth = 2.0
        self.productAddButton.layer.borderColor = UIColor.blue.cgColor
        if(self.productQuantity.text != "0") {
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
    
    func setProduct(product: Product) {
        if let imageUrl = product.imageUrl {
            self.productImageView.kf.setImage(with: URL(string: imageUrl))
        }
        else {
            self.productImageView.image = #imageLiteral(resourceName: "noimage")
        }
        self.productTitle.text = product.name
        if let productPrice = product.price {
            self.productPrice.text = "$" + String(productPrice)
        }
        self.productId = product.id
        self.productQuantity.text = String(ModelManager.shared.productsCart[product.id!] ?? 0)
         
    }
    
    @IBAction func productAddButtonAction(_ sender: UIButton) {
        if let index = indexPath {
            delegate?.productTableViewCellDidTapAdd(id: productId!,indexPath: index)
        } else {
            print("No index path")
        }
    }
    @IBAction func productPlusButtonAction(_ sender: UIButton) {
        if let index = indexPath {
            delegate?.productTableViewCellDidTapPlus(id: productId!,indexPath: index)
        } else {
            print("No index path")
        }
    }
    
    @IBAction func productMinusButtonAction(_ sender: UIButton) {
        if let index = indexPath {
            delegate?.productTableViewCellDidTapMinus(id: productId!,indexPath: index)
        } else {
            print("No index path")
        }
    }
}

protocol ProductTableViewCellDelegate : class {
    func productTableViewCellDidTapAdd(id: Int, indexPath: IndexPath)
    func productTableViewCellDidTapPlus(id: Int,indexPath: IndexPath)
    func productTableViewCellDidTapMinus(id: Int,indexPath: IndexPath)
}
