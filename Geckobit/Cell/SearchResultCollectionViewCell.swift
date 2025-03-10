//
//  SearchResultTableViewCell.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//

import UIKit

final class SearchResultCollectionViewCell: BaseCollectionViewCell {
    private let coinView = CoinProfileViewWithRank()
    
    override func configureHierarchy() {
        addSubview(coinView)
    }
    
    override func configureLayout() {
        coinView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        coinView.reset()
    }
        
    func configureData(_ data: SearchResult) {
        coinView.configureProfile(data)
    }
}
