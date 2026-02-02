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
    
    func fetch<T: Decodable>(api: PhotoRouter, type: T.Type, completionHandler: @escaping (T) -> Void, failureHandler: @escaping () -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(">>> 에러 발생 >>> 에러: \(error)")
                    failureHandler()
                }
            }
    }
}
