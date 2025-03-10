//
//  BackButtonView.swift
//  Geckobit
//
//  Created by ilim on 2025-03-11.
//

import UIKit

final class BackButtonView: BaseView {
    private(set) var button = UIButton()
    
    override func configureHierarchy() {
        addView(button)
    }
    
    override func configureLayout() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: C.back)
        config.baseForegroundColor = .customNavy
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button.configuration = config
    }
}
