//
//  CoinInfoViewModel.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//

import Foundation
import RxCocoa
import RxSwift

final class CoinInfoViewModel {
    private let disposeBag = DisposeBag()
    
    struct Output {
        let currentTime: PublishRelay<String>
        let trendCoins: Driver<[CoinItemDetail]>
        let trendNFTs: Driver<[NFTItem]>
    }
    
    func transform() -> Output {
        let coin = PublishRelay<[CoinItemDetail]>()
        let nft = PublishRelay<[NFTItem]>()
        let time = PublishRelay<String>()
        
        let trending = fetchTrending().publish()
        
        trending
            .map { $0.coins.map { $0.item } }
            .bind(to: coin)
            .disposed(by: disposeBag)
        
        trending
            .map { $0.nfts }
            .bind(to: nft)
            .disposed(by: disposeBag)
        
        trending
            .map { _ in Date().dateToString(format: C.searchFormat) }
            .bind(to: time)
            .disposed(by: disposeBag)
        
        trending.connect().disposed(by: disposeBag)

        return Output(
            currentTime: time,
            trendCoins: coin.asDriver(onErrorJustReturn: []),
            trendNFTs: nft.asDriver(onErrorJustReturn: []))
    }
    
    private func fetchTrending() -> Observable<TrendingResponse> {
        let request = GeckoRouter.trending
        
        return Observable<Int>.interval(.seconds(C.trendingInterval), scheduler: MainScheduler.instance)
            .startWith(0)
            .flatMapLatest { _ in
                return APIManager.shared.requestAPI(request)
            }
    }
}



