//
//  CoinDetailViewModel.swift
//  Geckobit
//
//  Created by ilim on 2025-03-11.
//

import Foundation
import RxSwift
import RxCocoa

final class CoinDetailViewModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let id: BehaviorRelay<String>
    }
    
    struct Output {
        let detail: Driver<[MarketResponse]>
        let tooManyError: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let detail = PublishRelay<[MarketResponse]>()
        let tooManyError = PublishRelay<Bool>()
        
        input.id
            .filter { !$0.isEmpty }
            .bind(with: self) { owner, id in
                owner.fetchCoinDetail(id)
                    .do(onError: { _ in
                        tooManyError.accept(true)
                    })
                    .catchAndReturn([])
                    .subscribe(onNext: { response in
                        if !response.isEmpty {
                            tooManyError.accept(false)
                        }
                        detail.accept(response)
                    })
                    .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)
        
        return Output(
            detail: detail.asDriver(onErrorJustReturn: []),
            tooManyError: tooManyError.asDriver(onErrorJustReturn: false))
    }
    
    private func fetchCoinDetail(_ id: String) -> Observable<[MarketResponse]> {
        let request = GeckoRouter.market(ids: id)
        return APIManager.shared.requestAPI(request)
    }
}
