//
//  APIManager.swift
//  Geckobit
//
//  Created by ilim on 2025-03-06.
//

import Foundation
import Alamofire

final class APIManager {
    static let shared = APIManager()
    
    private init() { }
    
    func requestAPI<T: Decodable, U: URLRequestConvertible>(_ router: U, _ completionHandler: @escaping (T) -> Void) {
        print(router.urlRequest?.url)
        AF.request(router).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                dump(error)
//                guard let statusCode = response.response?.statusCode else { return }
//                ErrorAlert.shared.statusCode = statusCode
            }
        }
    }
}
