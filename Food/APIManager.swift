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
    
    func requestStore(query: String) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let url = EndPoint.url + "query=\(text ?? "맛집")&category_group_code=FD6"
        
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.Kakao_SECRET)"]
        
        AF.request(url, method: .get ,headers: header).validate(statusCode: 200...400).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                 print("JSON: \(json)")
              
              
                
            case .failure(let error):
                print(error)
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
                 print("JSON: \(json)")
                
                let region = json["results"][0]["region"]
                
                let regionData = RegionInfo(firstArea: region["area1"]["alias"].stringValue, secondArea: region["area2"]["name"].stringValue, thirdArea: region["area3"]["name"].stringValue)
               
              completionHandler(regionData)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
