//
//  CheckoutViewController.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 4/21/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    @IBAction func doCheckoutButton(_ sender: Any) {
        let alertCheckoutDone = UIAlertController(title: "Purchase successful", message: "Come back with us", preferredStyle: .alert)
        alertCheckoutDone.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
                // implement here quit view from stack
        }))
        
        self.present(alertCheckoutDone, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
