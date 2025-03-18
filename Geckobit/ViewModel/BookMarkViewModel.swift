//
//  BookMarkViewModel.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//

import Foundation
import RxCocoa
import RxSwift

final class BookMarkViewModel {
    private let disposeBag = DisposeBag()
    private var coinId = ""
    
    struct Input {
        let initialButtonStatus: PublishRelay<String>
        let likeButtonTapped: Observable<Bool>
    }
    
    struct Output {
        let isSelected: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let isSelected = PublishRelay<Bool>()
        
        input.initialButtonStatus
            .bind(with: self) { owner, value in
                owner.coinId = value
                let exists = RealmRepository.shared.isIdExist(id: value)
                isSelected.accept(exists)
            }
            .disposed(by: disposeBag)
        
        input.likeButtonTapped
            .bind(with: self) { owner, isButtonSelected in
                let newStatus = !isButtonSelected
                
                if isButtonSelected {
                    RealmRepository.shared.remove(id: owner.coinId)
                } else {
                    RealmRepository.shared.add(id: owner.coinId)
                }
                
                isSelected.accept(newStatus)
                owner.sendMessage(newStatus)
            }
            .disposed(by: disposeBag)

        return Output(isSelected: isSelected.asDriver(onErrorJustReturn: false))
    }
    
    private func sendMessage(_ result: Bool) {
        let suffix = C.BookMarkMessage[result]
        let message = "\(coinId)\(suffix ?? "")"
        presentToast(message)
    }
}
