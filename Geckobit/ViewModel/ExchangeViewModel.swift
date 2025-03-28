//
//  ExchangeViewModel.swift
//  Geckobit
//
//  Created by ilim on 2025-03-09.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

final class ExchangeViewModel {
    private let disposeBag = DisposeBag()
    private let coins = BehaviorRelay<[UpbitResponse]>(value: [])
    private let filteredCoins = PublishRelay<[UpbitResponse]>()

    private var currentColumn: Column = .tradingVolume
    private var currentSort: Sort = .descending
    
    struct Input {
        let columnTapped: PublishRelay<Int>
    }
    
    struct Output {
        let coins: Driver<[UpbitResponse]>
        let column: PublishRelay<ColumnState>
        let headers: Driver<[HeaderItem]>
    }
    
    func transform(input: Input) -> Output {
        let column = PublishRelay<ColumnState>()
        let headers = BehaviorRelay<[HeaderItem]>(value: [])
        var items: [HeaderItem] = []
        
        for (i, title) in C.columnTitle.enumerated() {
            let isCoin = title == C.coin
            let item = isCoin
            ? HeaderItem(title: title, tag: i, isFilter: false)
            : HeaderItem(title: title, tag: i, isFilter: true)
            items.append(item)
        }
        
        headers.accept(items)
        
        fetchCoins()
            .bind(to: coins)
            .disposed(by: disposeBag)
        
        coins
            .withUnretained(self)
            .map { owner, response in
                return owner.sortCoins(response)
            }
            .bind(to: filteredCoins)
            .disposed(by: disposeBag)
                
        input.columnTapped
            .bind(with: self) { owner, tag in
                let selectedColumn = Column(rawValue: tag) ?? .none
                let sameColumn = owner.currentColumn == selectedColumn
                
                if sameColumn {
                    owner.updateSort()
                } else {
                    owner.currentSort = .descending
                }
                
                owner.currentColumn = selectedColumn
                
                let currentState = ColumnState(column: owner.currentColumn, sort: owner.currentSort)
                column.accept(currentState)
                
                let data = owner.sortCoins(owner.coins.value)
                owner.filteredCoins.accept(data)
            }
            .disposed(by: disposeBag)
        
        return Output(
            coins: filteredCoins.asDriver(onErrorJustReturn: []),
            column: column,
            headers: headers.asDriver(onErrorJustReturn: []))
    }
        
    private func updateSort() {
        switch currentSort {
        case .none:
            currentSort = .descending
        case .descending:
            currentSort = .ascending
        case .ascending:
            currentSort = .none
        }
    }
    
    private func fetchCoins() -> Observable<[UpbitResponse]> {
        let request = UpbitRouter.market
        
        return Observable<Int>.interval(.seconds(C.exchangeInterval), scheduler: MainScheduler.instance)
            .startWith(0)
            .enumerated()
            .flatMapLatest { index, _ -> Observable<[UpbitResponse]> in
                let showLoading = index == 0
                return APIManager.shared.requestAPI(request, showLoading: showLoading)
            }
    }

    
    private func sortCoins(_ response: [UpbitResponse]) -> [UpbitResponse] {
        if currentSort == .none {
            return response
        }
        
        let isAscending = currentSort == .ascending
        
        switch currentColumn {
        case .none:
            return response
        case .currentPrice:
            return response.sorted { isAscending ?
                $0.trade_price < $1.trade_price :
                $0.trade_price > $1.trade_price
            }
        case .priceChangeRate:
            return response.sorted { isAscending ?
                $0.signed_change_rate < $1.signed_change_rate :
                $0.signed_change_rate > $1.signed_change_rate
            }
        case .tradingVolume:
            return response.sorted { isAscending ?
                $0.acc_trade_price_24h < $1.acc_trade_price_24h :
                $0.acc_trade_price_24h > $1.acc_trade_price_24h
            }
        }
    }
}
