//
//  APIManager.swift
//  Geckobit
//
//  Created by ilim on 2025-03-06.
//

import Foundation
import Alamofire
import RxSwift

final class APIManager {
    static let shared = APIManager()
    
    private init() { }
    
    func requestAPI<T: Decodable, U: URLRequestConvertible>(_ router: U) -> Observable<T> {
        return Observable.create { observer in
            let request = AF.request(router).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create { request.cancel() }
        }
    }
}
