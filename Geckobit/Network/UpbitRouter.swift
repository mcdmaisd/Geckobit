//
//  UpbitRouter.swift
//  Geckobit
//
//  Created by ilim on 2025-03-06.
//

import Foundation
import Alamofire

enum UpbitRouter: URLRequestConvertible {
    case market
    
    private var baseURL: URL {
        return URL(string: AC.upbitURL)!
    }
    
    private var method: HTTPMethod {
        return .get
    }
        
    private var parameter: Parameters {
        return [AC.upbitKey: AC.currencyValue]
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: baseURL)
        
        request.method = method
        request = try URLEncoding.default.encode(request, with: parameter)
    
        return request
    }
}
