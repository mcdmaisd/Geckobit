//
//  SearchCoinViewModel.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//

import Foundation
import RxCocoa
import RxSwift

final class SearchCoinViewModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let keyword: BehaviorRelay<String>
    }
    
    struct Output {
        let coins: Driver<[SearchResult]>
        let scrollToTop: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let result = PublishRelay<[SearchResult]>()
        let scrollToTop = PublishRelay<Bool>()

        input.keyword
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .bind(with: self) { owner, value in
                owner.fetchCoinDetail(value)
                    .map { $0.coins }
                    .subscribe(onNext: { response in
                        result.accept(response)
                        scrollToTop.accept(true)
                    })
                    .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)
        
        return Output(
            coins: result.asDriver(onErrorJustReturn: []),
            scrollToTop: scrollToTop.asDriver(onErrorJustReturn: false))
    }

    private func fetchCoinDetail(_ keyword: String) -> Observable<SearchResponse> {
        let request = GeckoRouter.search(keyword: keyword)
        return APIManager.shared.requestAPI(request)
    }
}
