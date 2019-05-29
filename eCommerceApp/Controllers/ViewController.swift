//
//  ViewController.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 4/20/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //Lets and vars
    
    let modelManager = ModelManager.shared
    let apiManager = ApiModelManager.shared
    
    var sections:[String] = []
    var sectionsProducts: [Int:[Product]] = [:]
    var currentProducts: [Int:[Product]] = [:]

    
    //Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.getBanners(completion: { (banners, error) in
            self.bannerCollectionView.reloadData()
        })

        setUpBanners()
        setUpSearchBar()
        setUpTableView()
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiManager.getAllProducts { (products, error) in
            self.setSections(products: products ?? [])
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func setSections(products: [Product]){
        for product in products{
            let index = sections.firstIndex(of: product.cat!)
            
            if (index == nil){
                sectionsProducts[sections.count] = [product]
                sections.append(product.cat!)
            }
            else
            {
                var aux = sectionsProducts[index!]
                aux!.append(product)
                sectionsProducts[index!] = aux
            }
        }
        currentProducts = sectionsProducts
    }
    
    //IBActions
    
    @IBAction func goToCart(_ sender: Any) {
        modelManager.isCheckout = true
        self.performSegue(withIdentifier: "goToCartSegue", sender:  self)
    }
    
    @IBAction func goToPurchaseHistory(_ sender: Any) {
        self.performSegue(withIdentifier: "goToPurchaseHistory", sender: self)
    }
}

//Extension for TableView

extension ViewController: UITableViewDataSource, UITableViewDelegate, ProductTableViewCellDelegate {
    
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return currentProducts.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentProducts[section]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCell(withIdentifier: "productToSale", for: indexPath) as! ProductTableViewCell
        productCell.setProduct(product: currentProducts[indexPath.section]![indexPath.row])
        productCell.indexPath = indexPath
        productCell.delegate = self
        productCell.selectionStyle = .none
        
        return productCell
    }
    
    func productTableViewCellDidTapAdd(id: Int, indexPath: IndexPath) {
        modelManager.changeItemQuantity(key: id, number: 1)
        tableView.reloadData()
    }
    
    func productTableViewCellDidTapPlus(id: Int, indexPath: IndexPath) {
        if let itemQuantity = modelManager.productsCart[id] {
            modelManager.changeItemQuantity(key: id, number: itemQuantity + 1)
        }
        tableView.reloadData()
    }
    
    func productTableViewCellDidTapMinus(id: Int, indexPath: IndexPath) {
        if let itemQuantity = modelManager.productsCart[id] {
            modelManager.changeItemQuantity(key: id, number: itemQuantity - 1)
            if modelManager.productsCart[id]! < 0 {
                modelManager.productsCart.removeValue(forKey: id)
            }
        }
        tableView.reloadData()
    }
    
    func setUpTableView() {
        tableView.scrollsToTop = false
    }
}

//Extension for Collection View

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ModelManager.shared.banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bannerCell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "banner", for: indexPath) as! BannerCollectionViewCell
        
        bannerCell.setBanner(banner: ModelManager.shared.banners[indexPath.row])
        
        return bannerCell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bannerCollectionView.bounds.width, height: bannerCollectionView.bounds.height)
    }
    
    func setUpBanners() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize.width = bannerCollectionView.frame.width
        layout.itemSize.height = bannerCollectionView.frame.height
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        bannerCollectionView.setCollectionViewLayout(layout, animated: false)
        bannerCollectionView.isPagingEnabled = true
        bannerCollectionView.alwaysBounceVertical = false
        bannerCollectionView.showsHorizontalScrollIndicator = false
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
    }
}

//Extension for SearchBar

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentProducts = sectionsProducts;
            tableView.reloadData()
            return
        }
        
        for (index, section) in sectionsProducts {
            currentProducts[index] = section.filter({ (product) -> Bool in
                guard let text = searchBar.text else {return false}
                return String(product.name!).lowercased().contains(text.lowercased())
            })
        }
        tableView.reloadData()
    }
    
    func setUpSearchBar() {
        searchBar.barTintColor = UIColor.lightGray
        searchBar.layer.cornerRadius = CGFloat(roundf(Float(self.searchBar.frame.size.height / 2.0)))
        searchBar.delegate = self
    }
}
