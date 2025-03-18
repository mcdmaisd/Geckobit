//
//  BookMark.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//

import UIKit
import RxCocoa
import RxSwift

final class BookMarkView: BaseView {
    private let disposeBag = DisposeBag()
    private let viewModel = BookMarkViewModel()
    private let initialStatus = PublishRelay<String>()
    private let button = UIButton()
    
    override func configureHierarchy() {
        addView(button)
    }
    
    override func configureLayout() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        bind()
    }
    
    private func bind() {
        let input = BookMarkViewModel.Input(
            initialButtonStatus: initialStatus,
            likeButtonTapped: button.rx.tap.map { self.button.isSelected })
        let output = viewModel.transform(input: input)
        
        output.isSelected
            .drive(button.rx.isSelected)
            .disposed(by: disposeBag)
    }
        
    func configureButton(_ id: String) {
        initialStatus.accept(id)
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .customNavy
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        button.configuration = config
        button.configurationUpdateHandler = { btn in
            switch btn.state {
            case .selected:
                btn.configuration?.image = UIImage(systemName: C.starFill)
            default:
                btn.configuration?.image = UIImage(systemName: C.star)
            }
        }
    }
    
    func reset() {
        button.isSelected = false
    }
}
