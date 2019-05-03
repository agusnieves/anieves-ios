//
//  CheckoutViewController.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 4/21/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var checkoutCollectionView: UICollectionView!
    @IBOutlet weak var totalValue: UILabel!
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
            self.checkoutCollectionView.reloadData()
            // implement here quit view from stack
        }))
        
        self.present(alertCheckoutDone, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkoutCollectionView.dataSource = self
        checkoutCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        product = createPIC()
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
