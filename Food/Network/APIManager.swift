//
//  APIManager.swift
//  Food
//
//  Created by J on 2022/09/15.
//

import Foundation

import Alamofire
import SwiftyJSON

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
    
    func requestRegion(lat: Double, lon: Double, _ completionHandler: @escaping (RegionInfo) -> Void) {
 
        let url = EndPoint.geoURL + "coords=\(lon),\(lat)&output=json"
        
        let header: HTTPHeaders = [
            "X-NCP-APIGW-API-KEY-ID": APIKey.MapID,
            "X-NCP-APIGW-API-KEY": APIKey.MapKey
        ]
        
        AF.request(url, method: .get ,headers: header).validate(statusCode: 200...400).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
      
                let region = json["results"][0]["region"]
                
                let regionData = RegionInfo(firstArea: region["area1"]["alias"].stringValue, secondArea: region["area2"]["name"].stringValue, thirdArea: region["area3"]["name"].stringValue)
               
              completionHandler(regionData)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
