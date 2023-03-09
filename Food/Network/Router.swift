//
//  Router.swift
//  Food
//
//  Created by J on 2023/03/08.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
case store(query: String?, page: Int)
case region(lon: Double, lat: Double)
    
    var baseURL: URL {
        switch self {
        case .store:
            return URL(string: EndPoint.url)!
        case .region:
            return URL(string: EndPoint.geoURL)!
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .store(let query, let page):
            return [
                "query": query ?? "맛집",
                "category_group_code": "FD6",
                "page": page
            ]
        case .region(let lon, let lat):
            return [
                "coords": "\(lon),\(lat)",
                "output": "json"
            ]
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .store:
            return [
                "Authorization": "KakaoAK \(APIKey.Kakao_SECRET)"
            ]
        case .region:
            return [
                "X-NCP-APIGW-API-KEY-ID": APIKey.MapID,
                "X-NCP-APIGW-API-KEY": APIKey.MapKey
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .store, .region:
            return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
