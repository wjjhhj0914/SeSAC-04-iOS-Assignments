//
//  NetworkManager.swift
//  Day20_Assignment
//
//  Created by Hyojung Jang on 1/28/26.
//

import Foundation
import Alamofire

enum UnsplashError: Int, Error, LocalizedError {
    case badRequest = 400 // The request was unacceptable, often due to missing a required parameter
    case unauthorized = 401 // Invalid Access Token
    case forbidden = 403 // Missing permissions to perform request
    case notFound = 404 // The request resource doesn't exist
    case serverError = 500 // something went wrong on our end
    case unknown = -1
    
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "잘못된 요청입니다."
        case .unauthorized:
            return "인증 오류입니다."
        case .forbidden:
            return "요청 횟수 초과입니다."
        case .notFound:
            return "데이터를 찾을 수 없습니다."
        case .serverError:
            return "서버 문제가 발생했습니다."
        case .unknown:
            return "알 수 없는 에러입니다."
        }
    }
}

typealias Networking<T> = Result<T, UnsplashError>

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(
        api: PhotoRouter,
        type: T.Type,
        completionHandler: @escaping (Networking<T>) -> Void
    ) {
        AF.request(
            api.endpoint, method: api.method, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) { response in
                let statusCode = response.response?.statusCode ?? -1
                switch response.result {
                case .success(let value):
                    if statusCode == 200 {
                        completionHandler(.success(value))
                    } else {
                        let error = UnsplashError(rawValue: statusCode) ?? .unknown
                        completionHandler(.failure(error))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completionHandler(.failure(.unknown))
                }
            }
    }
}
