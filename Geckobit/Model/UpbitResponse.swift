//
//  Upbit.swift
//  Geckobit
//
//  Created by ilim on 2025-03-06.
//

import Foundation

struct UpbitResponse: Decodable {
    let market: String
    let signed_change_price: Double
    let signed_change_rate: Double
    let acc_trade_price_24h: Double
    let trade_price: Double
}
