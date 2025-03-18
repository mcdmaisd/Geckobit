//
//  Gecko.swift
//  Geckobit
//
//  Created by ilim on 2025-03-06.
//

import Foundation

struct MarketResponse: Decodable {
    let id: String
    let name: String
    let symbol: String
    let image: String
    let current_price: Double
    let price_change_percentage_24h: Double
    let last_updated: String
    let low_24h: Double
    let high_24h: Double
    let ath: Double
    let ath_date: String
    let atl: Double
    let atl_date: String
    let market_cap: Double
    let market_cap_rank: Int
    let fully_diluted_valuation: Double
    let total_volume: Double
    let sparkline_in_7d: SparklineData
}

struct SparklineData: Decodable {
    let price: [Double]
}

struct SearchResponse: Decodable {
    let coins: [SearchResult]
}

struct SearchResult: Decodable {
    let id: String
    let name: String
    let symbol: String
    let market_cap_rank: Int?
    let thumb: String
    let large: String
}

struct TrendingResponse: Decodable {
    let coins: [CoinItem]
    let nfts: [NFTItem]
}

struct CoinItem: Decodable {
    let item: CoinItemDetail
}

struct CoinItemDetail: Decodable {
    let id: String
    let coin_id: Int
    let name: String
    let symbol: String
    let thumb: String
    let small: String
    let large: String
    let data: CoinData
}

struct CoinData: Decodable {
    let price: Double
    let price_change_percentage_24h: PriceChangePercentage
}

struct PriceChangePercentage: Decodable {
    let krw: Double
}

struct NFTItem: Decodable {
    let name: String
    let thumb: String
    let floor_price_24h_percentage_change: Double
    let data: NFTData
}

struct NFTData: Decodable {
    let floor_price: String
}

