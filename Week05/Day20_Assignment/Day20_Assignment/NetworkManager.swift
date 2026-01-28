//
//  NetworkManager.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/28/26.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func callRequestPhoto(query: String, page: Int, color: String?, sort: String, completionHandler: @escaping (PhotoSearchResponse) -> Void) {
        let url = "https://api.unsplash.com/search/photos"
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(APIKey.UNSPLASH_ACCESS)"]
        var parameters: Parameters = [
            "query": query,
            "page": page,
            "per_page": 20,
            "order_by": sort
        ]
        
        if let color = color {
            parameters["color"] = color
        }
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: PhotoSearchResponse.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                    
                case .failure(let error):
                    print(">>> 에러 발생 >>> 에러: \(error)")
                }
            }
    }
    
    func callRequestStatistics(id: String, completionHandler: @escaping (PhotoStatistics) -> Void) {
        let url = "https://api.unsplash.com/photos/\(id)/statistics"
        let headers: HTTPHeaders = ["Authorization": "Client-ID \(APIKey.UNSPLASH_ACCESS)"]
        
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: PhotoStatistics.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(">>> 에러 발생 >>> 에러: \(error)")
                }
            }
    }
    
    

}
