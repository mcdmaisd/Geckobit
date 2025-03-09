//
//  Constant.swift
//  Geckobit
//
//  Created by ilim on 2025-03-06.
//

import Foundation

struct Constant {
    //MARK: Font Size
    static let small: CGFloat = 9
    static let medium: CGFloat = 12
    static let large: CGFloat = 20
    //MARK: Icon Size
    static let smallIcon: CGFloat = 26
    static let mediumIcon: CGFloat = 36
    static let largeIcon: CGFloat = 72
    //MARK: Interval
    static let exchangeInterval = 5
    static let trendingInterval = 600
    //MARK: system Image
    static let up = "arrowtriangle.up"
    static let down = "arrowtriangle.down"
    static let arrows = [up, down]
    static let upFill = "arrowtriangle.up.fill"
    static let downFill = "arrowtriangle.down.fill"
    static let search = "magnifyingglass"
    static let star = "star"
    static let starFill = "star.fill"
    static let right = "chevron.right"
    static let back = "arrow.left"
    static let barChart = "chart.bar.fill"
    static let lineChart = "chart.line.uptrend.xyaxis"
    //MARK: Title
    static let exchangeTitle = "거래소"
    static let searchTitle = "가상자산/심볼 검색"
    static let coin = "코인"
    //MARK: TabBar
    static let tabbarTitles = [exchangeTitle, "코인정보", "포트폴리오"]
    static let tabbarImages = [lineChart, barChart, star]
    //MARK: column
    static let columnTitle = [coin, "현재가", "전일대비", "거래대금"]
    static let million: Double = 1000000
    static let millionSuffix = "백만"
}
