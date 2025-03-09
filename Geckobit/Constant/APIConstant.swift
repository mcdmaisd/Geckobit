//
//  APIConstant.swift
//  Geckobit
//
//  Created by ilim on 2025-03-06.
//

import Foundation

struct APIConstant {
    //MARK: baseURL
    static let upbitURL = "https://api.upbit.com/v1/ticker/all"
    static let geckoURL = "https://api.coingecko.com/api/v3/"
    //MARK: Upbit params
    static let upbitKey = "quote_currencies"
    //MARK: Gecko params
    static let geckoCurrency = "vs_currency"
    static let geckoSearch = "query"
    static let ids = "ids"
    static let sparkline = "sparkline"
    static let sparklineValue = "true"
    //MARK: common value
    static let currencyValue = "KRW"
    //MARK: path
    static let search = "search"
    static let trending = "trending"
    static let coins = "coins"
    static let markets = "markets"
    //MARK: Separator
    static let separator = "/"
}
