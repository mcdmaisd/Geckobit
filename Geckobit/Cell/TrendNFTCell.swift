//
//  TrendNFTCell.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//

import UIKit

final class TrendNFTCell: BaseCollectionViewCell {
    private let nftView = NFTProfileView()
    
    override func configureHierarchy() {
        addSubview(nftView)
    }
    
    override func configureLayout() {
        nftView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nftView.reset()
    }
        
    func configureData(_ data: NFTItem) {
        nftView.configureProfile(data)
    }
}

