//
//  PhotoRouter.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 2/2/26.
//

import Foundation
import Alamofire

enum PhotoRouter {
    case search(query: String, page: Int, color: String?, sort: String)
    case statistics(id: String)
    case topics(topicName: String)
    
    var baseURL: String {
        return "https://api.unsplash.com"
    }
    
    var endpoint: String {
        switch self {
        case .search:
            return "\(baseURL)/search/photos"
        case .statistics(let id):
            return "\(baseURL)/photos/\(id)/statistics"
        case .topics(let topicName):
            return "\(baseURL)/topics/\(topicName)/photos"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: HTTPHeaders {
        ["Authorization": "Client-ID \(APIKey.UNSPLASH_ACCESS)"]
    }
    
    var parameters: Parameters {
        switch self {
        case .search(let query, let page, let color, let sort):
            var params: Parameters = ["query": query, "page": page, "per_page": 20, "order_by": sort]
            if let color = color { params["color"] = color }
            return params
        case .statistics, .topics:
            return ["": ""]
        }
    }
}
