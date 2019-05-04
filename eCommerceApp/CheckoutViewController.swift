//
//  CheckoutViewController.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 4/21/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var emptyCartMsj: UILabel!
    @IBOutlet weak var checkoutCollectionView: UICollectionView!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    var modelManager = ModelManager.shared
    var product: [Product] = []
    var total: Int = 0
    
    func createPIC() -> [Product] {
        
        for value in modelManager.productsCart.values {
            product.append(value)
            total = total + (value.price * value.quantity)
        }
        return product
        
    }
    
    @IBAction func doCheckoutButton(_ sender: Any) {
        let alertCheckoutDone = UIAlertController(title: "Purchase successful", message: "Come back with us", preferredStyle: .alert)
        alertCheckoutDone.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
            self.modelManager.productsCart.removeAll()
            self.navigationController?.popViewController(animated: false)
        }))
        
        self.present(alertCheckoutDone, animated: true, completion: nil)
        
    }
    
    func setCheckoutStatus() {
        if(modelManager.productsCart.count == 0) {
            checkoutButton.isEnabled = false
            checkoutButton.backgroundColor = UIColor.lightGray
            emptyCartMsj.text = "Your cart is empty"
            emptyCartMsj.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkoutButton.layer.cornerRadius = CGFloat(roundf(Float(self.checkoutButton.frame.size.height / 2.0)))
        checkoutCollectionView.dataSource = self
        checkoutCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emptyCartMsj.isHidden = true
        product = createPIC()
        self.setCheckoutStatus()
        totalValue.text = "$ " + String(total)
        checkoutCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CheckoutViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = checkoutCollectionView.dequeueReusableCell(withReuseIdentifier: "productInCart", for: indexPath) as! ProductInCartCollectionViewCell
        
        itemCell.setProductInCart(productInCart: product[indexPath.row])
        
        return itemCell
    }
}
