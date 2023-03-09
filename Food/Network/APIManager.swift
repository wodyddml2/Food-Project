//
//  APIManager.swift
//  Food
//
//  Created by J on 2022/09/15.
//

import Foundation

import Alamofire

class RequestSearchAPIManager {
    static let shared = RequestSearchAPIManager()
    
    private init() { }
    
    func requestAPI<T: Codable>(type: T.Type = T.self, router: URLRequestConvertible, _ completion: @escaping(Result<T, AFError>) -> Void) {
        AF.request(router).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
