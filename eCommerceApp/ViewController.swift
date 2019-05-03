//
//  ViewController.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 4/20/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    let modelManager = ModelManager.shared
    let listOfSections: [String] = ["Fruits", "Veggies"]
    var products: [[Product]] = [[]]
    var banners: [Banner] = []
    var productsInCart: [Int:Product] = [:]
    
    func createProducts() -> [[Product]] {
        
        let kiwi = Product(id: 1,image: #imageLiteral(resourceName: "Kiwi"), name: "Kiwi", price: 30)
        let grapefruit = Product(id: 2,image: #imageLiteral(resourceName: "Grapefruit"), name: "Grapefruit", price: 30)
        let watermelon = Product(id: 3,image: #imageLiteral(resourceName: "Watermelon"), name: "Watermelon", price: 45)
        let avocado = Product(id: 4,image: #imageLiteral(resourceName: "Avocado"), name: "Avocado", price: 30)
        let cucumber = Product(id: 5,image: #imageLiteral(resourceName: "Cucumber"), name: "Cucumber", price: 30)
        
        
        return [[kiwi, grapefruit, watermelon],[avocado,cucumber]]
        
    }
    
    func createBanners() -> [Banner] {
        
        let banner1 = Banner(image: #imageLiteral(resourceName: "Banner-1"), name: "Brazilian Bananas", note: "Product of the month")
        let banner2 = Banner(image: #imageLiteral(resourceName: "Banner-3"), name: "African cucumbers", note: "Product of the month")
        let banner3 = Banner(image: #imageLiteral(resourceName: "Banner-4"), name: "Ecuatorian Kiwis", note: "Product of the month")
        let banner4 = Banner(image: #imageLiteral(resourceName: "Banner-2"), name: "Uruguayan Grapefruits", note: "Product of the month")
        
        return [banner1, banner2, banner3, banner4]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        banners = createBanners()
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        products = createProducts()
        
        tableView.reloadData()
    }
    
    @IBAction func goToCart(_ sender: Any) {
        self.performSegue(withIdentifier: "goToCartSegue", sender:  self)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, ProductTableViewCellDelegate {
    
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listOfSections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let productCell = tableView.dequeueReusableCell(withIdentifier: "productToSale", for: indexPath) as! ProductTableViewCell
        productCell.setProduct(product: products[indexPath.section][indexPath.row])
        productCell.indexPath = indexPath
        productCell.delegate = self
        productCell.selectionStyle = .none
        
        return productCell
    }
    
    func productTableViewCellDidTapAdd(id: Int, indexPath: IndexPath) {
        if let cell = self.tableView.cellForRow(at: indexPath) as? ProductTableViewCell {
            cell.isInCart = true
        }
        let productSelected = products[indexPath.section][indexPath.row]
        productSelected.quantity = 1
        modelManager.productsCart[id] = productSelected
        tableView.reloadData()
    }
    
    func productTableViewCellDidTapPlus(id: Int, indexPath: IndexPath) {
        modelManager.productsCart[id]?.quantity = (modelManager.productsCart[id]?.quantity ?? 0) + 1
        tableView.reloadData()
    }
    
    func productTableViewCellDidTapMinus(id: Int, indexPath: IndexPath) {
        guard let productInCart = modelManager.productsCart[id] else {
            return
        }
        productInCart.quantity = productInCart.quantity - 1
        if productInCart.quantity < 1 {
            if let cell = self.tableView.cellForRow(at: indexPath) as? ProductTableViewCell {
                cell.isInCart = false
            }
        }
        modelManager.productsCart.removeValue(forKey: id)
        tableView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bannerCell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "banner", for: indexPath) as! BannerCollectionViewCell
        
        bannerCell.setBanner(banner: banners[indexPath.row])
        
        return bannerCell
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return
    }*/
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
}
