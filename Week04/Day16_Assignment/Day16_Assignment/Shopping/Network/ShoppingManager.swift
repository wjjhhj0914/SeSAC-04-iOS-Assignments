//
//  ShoppingManager.swift
//  Day16_Assignment
//
//  Created by Hyojung Jang on 2/17/26.
//

import Foundation
import Alamofire

final class ShoppingManager {
    
    static let shared = ShoppingManager()
    
    private init() {}
    
    func callRequest(query: String, sort: String, completionHandler: @escaping (ShoppingData) -> Void) {
        print(#function)
        let url = "https://openapi.naver.com/v1/search/shop.json"
        let headers: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_CLIENT_ID, "X-Naver-Client-Secret": APIKey.NAVER_CLIENT_SECRET]
        let parameters: Parameters = ["query": query, "display": 100, "start": 1, "sort": sort]
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: ShoppingData.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
