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
    var products: [ProductInCart] = []

    func createPIC() -> [ProductInCart] {
        
        let kiwi = Product(id: 1,image: #imageLiteral(resourceName: "Kiwi"), name: "Kiwi", price: 30)
        let kiwiInCart = ProductInCart(product: kiwi, quantity: 1)
        let kiwiInCart1 = ProductInCart(product: kiwi, quantity: 1)
        let kiwiInCart2 = ProductInCart(product: kiwi, quantity: 1)

        return [kiwiInCart, kiwiInCart1, kiwiInCart2]
        
    }
    
    @IBAction func doCheckoutButton(_ sender: Any) {
        let alertCheckoutDone = UIAlertController(title: "Purchase successful", message: "Come back with us", preferredStyle: .alert)
        alertCheckoutDone.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
                // implement here quit view from stack
        }))
        
        self.present(alertCheckoutDone, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        products = createPIC()
        
        checkoutCollectionView.dataSource = self
        checkoutCollectionView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CheckoutViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = checkoutCollectionView.dequeueReusableCell(withReuseIdentifier: "productInCart", for: indexPath) as! ProductInCartCollectionViewCell
        
        itemCell.setProductInCart(productInCart: products[indexPath.row])
        
        return itemCell
    }
    
    
    
}
