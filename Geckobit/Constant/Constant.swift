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
    static let regular: CGFloat = 17
    static let large: CGFloat = 20
    //MARK: Icon Size
    static let smallIcon: CGFloat = 26
    static let mediumIcon: CGFloat = 36
    static let largeIcon: CGFloat = 72
    //MARK: Interval
    static let exchangeInterval = 5
    static let trendingInterval = 600
    //MARK: System Image
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
    static let nft = "NFT"
    //MARK: TabBar
    static let tabbarTitles = [exchangeTitle, "코인정보", "포트폴리오"]
    static let tabbarImages = [lineChart, barChart, star]
    static let upperTabbarTitles = [coin, nft, exchangeTitle]
    //MARK: Column
    static let columnTitle = [coin, "현재가", "전일대비", "거래대금"]
    static let million: Double = 1000000
    static let millionSuffix = "백만"
    //MARK: Date
    static let locale = "ko_KR"
    static let searchFormat = "MM.dd HH:mm '기준'"
    static let detailFormat = "M/d HH:mm:ss '업데이트'"
    static let alltimeFormat = "yy년 M월 d일"
    static let failureMessage = "Fail to convert date"
    //MARK: Text
    static let trendCoin = "인기 검색어"
    static let trendNFT = "인기 \(nft)"
    static let coinInfo = "종목정보"
    static let indicator = "투자지표"
    static let more = "더보기"
    static let highPrice24h = "24시간 고가"
    static let lowPrice24h = "24시간 저가"
    static let athPrice = "역대 최고가"
    static let atlPrice = "역대 최저가"
    static let marketCap = "시가총액"
    static let fdv = "완전 희석 가치(FDV)"
    static let volumeAmount = "총 거래량"
    static let placeholder = "검색어를 입력해주세요"
    //MARK: Popup
    static let popupTitle = "안내"
    static let popupDetail = "네트워크 연결이 일시적으로 원활하지 않습니다. 데이터 또는 Wi-Fi 연결 상태를 확인해주세요."
    static let popupButtonTtile = "다시 시도하기"
    //MARK: BookMark Message
    static let BookMarkMessage = [true: "이 즐겨찾기되었습니다.", false: "이 즐겨찾기에서 제거되었습니다."]
    static let noData = "준비 중입니다"
    //MARK: Alert Message
    static let tooManyRequests = "네트워크 요청이 너무 자주 요청 되었습니다.\n나중에 다시 시도해 주세요"
    //MARK: UserDefaults Key
    static let cellKey = "cell"
}
