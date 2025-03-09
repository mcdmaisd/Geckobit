//
//  APIRouter.swift
//  Geckobit
//
//  Created by ilim on 2025-03-06.
//

import Foundation
import Alamofire

enum GeckoRouter: URLRequestConvertible {
    case market(ids: String)
    case trending
    case search(keyword: String)
    
    private var baseURL: URL {
        return URL(string: AC.geckoURL)!
    }
    
    private var method: HTTPMethod {
        switch self {
        case .trending, .search, .market:
            return .get
        }
    }
        
    private var path: String {
        switch self {
        case .trending:
            return makePath([AC.search, AC.trending])
        case .search:
            return makePath([AC.search])
        case.market:
            return makePath([AC.coins, AC.markets])
        }
    }
    
    private var parameter: Parameters? {
        switch self {
        case .market(let ids):
            return [AC.geckoCurrency: AC.currencyValue, AC.ids: ids, AC.sparkline: AC.sparklineValue]
        case .trending:
            return nil
        case .search(let keyword):
            return [AC.geckoSearch: keyword]
        }
    }
    
    private func makePath(_ path: [String]) -> String {
        return path.compactMap { $0 }.joined(separator: AC.separator)
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        
        request.method = method
        
        if let parameter {
            request = try URLEncoding.default.encode(request, with: parameter)
        }
        
        return request
    }
}
