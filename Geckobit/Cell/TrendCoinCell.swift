//
//  TrendCoinCell.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//

import UIKit

final class TrendCoinCell: BaseCollectionViewCell {
    private let coinView = CoinProfileView()
    
    override func configureHierarchy() {
        addSubview(coinView)
    }
    
    override func configureLayout() {
        coinView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
        
    func configureData(_ data: CoinItemDetail, _ row: Int) {
        coinView.configureProfile(data, row)
    }
}
