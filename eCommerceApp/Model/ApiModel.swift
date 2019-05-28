//
//  ApiModel.swift
//  eCommerceApp
//
//  Created by Patricia Benitez on 5/22/19.
//  Copyright © 2019 Patricia Benitez. All rights reserved.
//
import Alamofire
import AlamofireObjectMapper

class ApiModelManager{
    
    static let shared = ApiModelManager()
    var token: String?
    let modelManager = ModelManager.shared
    

    let baseUrl = "https://us-central1-ucu-ios-api.cloudfunctions.net"
    
    private init(){
        AuthenticationManager.shared.authenticate { (authResponse) in
            print(authResponse)
            self.token = authResponse.token
        }
    }
    
    func getAllProducts(completion: @escaping ([Product]?, Error?) -> Void) {
        let url = baseUrl + "/products"
        
        Alamofire.request(url).validate().responseArray{ (response: DataResponse<[Product]>) in
            switch response.result {
            case .success:
//                print(response.result.value)
                ModelManager.shared.products = response.result.value ?? []
                ModelManager.shared.fillProductsById(products: ModelManager.shared.products)
                completion(response.value, nil)
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }
    
    func getBanners(completion: @escaping ([Banner]?, Error?) -> Void) {
        let url = baseUrl + "/promoted"
        
        Alamofire.request(url).validate().responseArray{ (response: DataResponse<[Banner]>) in
            switch response.result {
            case .success:
                ModelManager.shared.banners = response.result.value ?? []
                completion(response.value, nil)
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }
    
    func getAllPurchases(completion: @escaping ([Product]?, Error?) -> Void) {
        
    }
    
}
