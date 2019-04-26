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
    @IBAction func goToCartHeader(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToCartSegue", sender:  self)
    }
    
    let listOfSections: [String] = ["Fruits", "Veggies"]
    var products: [[Product]] = [[]]
    var banners: [Banner] = []
    
    func createProducts() -> [[Product]] {
        
        let kiwi = Product(image: #imageLiteral(resourceName: "Kiwi"), name: "Kiwi", price: "$30")
        let grapefruit = Product(image: #imageLiteral(resourceName: "Grapefruit"), name: "Grapefruit", price: "$45")
        let watermelon = Product(image: #imageLiteral(resourceName: "Watermelon"), name: "Watermelon", price: "$45")
        let avocado = Product(image: #imageLiteral(resourceName: "Avocado"), name: "Avocado", price: "$30")
        let cucumber = Product(image: #imageLiteral(resourceName: "Cucumber"), name: "Cucumber", price: "$30")
        
        
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
        products = createProducts()
        banners = createBanners()
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
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
    
    func productTableViewCellDidTapAdd(indexPath: IndexPath) {
        print(products[indexPath.section][indexPath.row].name)
    }
    
    func productTableViewCellDidTapPlus(_ sender: ProductTableViewCell) {
    
    }
    
    func productTableViewCellDidTapMinus(_ sender: ProductTableViewCell) {
        
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bannerCell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "banner", for: indexPath) as! BannerCollectionViewCell
        
        bannerCell.setBanner(banner: banners[indexPath.row])
        
        return bannerCell
    }
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
}
