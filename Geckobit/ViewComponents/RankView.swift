//
//  RankView.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//

import UIKit

final class RankView: BaseView {
    private let label = UILabel()
    
    override func configureHierarchy() {
        addView(label)
    }
    
    override func configureLayout() {
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    override func configureView() {
        self.backgroundColor = .customLightgray
        self.layer.cornerRadius = 5
        
        label.textColor = .customGray
        label.font = .systemFont(ofSize: C.small, weight: .bold)
    }
    
    func configureRank(_ data: Int) {
        label.text = "#\(data)"
    }
    
    func reset() {
        label.text = nil
    }
}
