//
//  NetworkMonitoring.swift
//  Geckobit
//
//  Created by ilim on 2025-03-11.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let networkManager = NetworkReachabilityManager()
    
    let isConnected = BehaviorRelay<Bool>(value: false)
    
    func startMonitoring() {
        networkManager?.startListening { status in
            switch status {
            case .reachable(.ethernetOrWiFi), .reachable(.cellular):
                self.isConnected.accept(true)
            case .notReachable, .unknown:
                self.isConnected.accept(false)
            }
        }
    }
}
