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
    var token: String = "SNOW"
    let modelManager = ModelManager.shared
    

    let baseUrl = "https://us-central1-ucu-ios-api.cloudfunctions.net"
    
    private init(){
        AuthenticationManager.shared.authenticate { (authResponse) in
            self.token = authResponse.token
        }
    }
    
    func getAllProducts(completion: @escaping ([Product]?, Error?) -> Void) {
        let url = baseUrl + "/products"
        
        Alamofire.request(url)
            .validate()
            .responseArray{ (response: DataResponse<[Product]>) in
            switch response.result {
            case .success:
                self.modelManager.products = response.result.value ?? []
                self.modelManager.fillProductsById(products: self.modelManager.products)
                completion(response.value, nil)
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }
    
    func getBanners(completion: @escaping ([Banner]?, Error?) -> Void) {
        let url = baseUrl + "/promoted"
        
        Alamofire.request(url)
            .validate()
            .responseArray{ (response: DataResponse<[Banner]>) in
            switch response.result {
            case .success:
                self.modelManager.banners = response.result.value ?? []
                completion(response.value, nil)
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }
    
    func getAllPurchases(completion: @escaping ([Purchase]?, Error?) -> Void) {
        let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
        
        Alamofire.request(baseUrl + "/purchases",method: .get, headers: headers)
            .validate()
            .responseArray{(response: DataResponse<[Purchase]>) in
                switch response.result {
                case .success:
                    self.modelManager.purchases = response.result.value ?? []
                    completion(response.value, nil)
                case .failure(let error):
                    completion(nil, error)
                    print(error)
                }
        }
    }
    
    func postPurchase(cart: [ProductInCart] , onCompletion: @escaping (Bool, String?) -> Void) {
        let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
        
        var params = Parameters()
        params.updateValue(cart.toJSON(), forKey: "cart")
        
        Alamofire.request(baseUrl + "/checkout", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .response { response in
            guard let error = response.error else {
                if response.response?.statusCode == 200 {
                    onCompletion(true, nil)
                } else {
                    onCompletion(false, "Error posting the purchase")
                }
                return
            }
            print(error)
            onCompletion(false, error.localizedDescription)
            return
        }
    }
    
}
