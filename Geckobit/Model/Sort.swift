//
//  SortTypes.swift
//  Geckobit
//
//  Created by ilim on 2025-03-09.
//

import Foundation

enum Sort {
    case none
    case descending
    case ascending
}

enum Column: Int {
    case none
    case currentPrice
    case priceChangeRate
    case tradingVolume
}

struct ColumnState {
    let column: Column
    let sort: Sort
}

struct HeaderItem {
    let title: String
    let tag: Int
    let isFilter: Bool
}
