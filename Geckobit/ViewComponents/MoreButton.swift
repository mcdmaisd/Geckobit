//
//  MoreButton.swift
//  Geckobit
//
//  Created by ilim on 2025-03-11.
//

import UIKit
import RxCocoa
import RxSwift

final class MoreButton: BaseView {
    private let disposeBag = DisposeBag()
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
        let imageConfig = UIImage.SymbolConfiguration(pointSize: C.medium)
        
        var config = UIButton.Configuration.plain()
        
        config.image = UIImage(systemName: C.right)
        config.preferredSymbolConfigurationForImage = imageConfig
        config.title = C.more
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer {
            var attributes = $0
            attributes.font = .systemFont(ofSize: C.medium)
            return attributes
        }
        
        config.imagePlacement = .trailing
        config.baseForegroundColor = .customGray
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        button.configuration = config
        button.rx.tap
            .subscribe { _ in
                presentToast(C.noData)
            }
            .disposed(by: disposeBag)
    }
}
