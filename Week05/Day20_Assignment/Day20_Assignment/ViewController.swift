//
//  ViewController.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/26/26.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest(query: "flower")
    }
    
    func callRequest(query: String) {
        let url = "https://api.unsplash.com/search/photos"
        
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID \(APIKey.UNSPLASH_ACCESS)"
        ]
        
        let parameters: Parameters = [
            "query": query,
            "page": 1,
            "per_page": 20
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: PhotoSearchResponse.self) { response in
                switch response.result {
                case .success(let value):
                    print(">>> 검색 결과 성공 >>>")
                    print("전체 사진 개수: \(value.total)")
                
                case .failure(let error):
                    print(">>> 에러 발생 >>> 에러: \(error)")
                }
            }
    }


}

