//
//  CoinTitleView.swift
//  Geckobit
//
//  Created by ilim on 2025-03-09.
//

import UIKit
import Kingfisher

final class CoinProfileViewWithRank: BaseView {
    private let number = UILabel()
    private let thumbnail = ThumbnailView()
    private let title = UILabel()
    private let subtitle = UILabel()
    private let rank = RankView()
    private let bookmark = BookMarkView()
    
    override func configureHierarchy() {
        addView(thumbnail)
        addView(title)
        addView(subtitle)
        addView(rank)
        addView(bookmark)
    }
    
    override func configureLayout() {
        thumbnail.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.verticalEdges.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(36)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(thumbnail)
            make.leading.equalTo(thumbnail.snp.trailing).offset(5)
        }
        
        subtitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom)
            make.leading.equalTo(title)
        }

        rank.snp.makeConstraints { make in
            make.leading.equalTo(title.snp.trailing).offset(5)
            make.centerY.equalTo(title)
        }
        
        bookmark.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.trailing.equalToSuperview()
        }
    }
    
    override func configureView() {
        [title, subtitle].forEach { $0.lineBreakMode = .byTruncatingTail }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        thumbnail.layer.cornerRadius = thumbnail.frame.width / 2
    }
    
    func configureProfile(_ data: SearchResult) {
        thumbnail.configureImage(data.large)
        title.titleLabel(text: data.symbol, fontSize: 14)
        subtitle.subtitleLabel(text: data.name, fontSize: C.medium)
        rank.configureRank(data.market_cap_rank)
        bookmark.configureButton(false)
    }
    
    func reset() {
        thumbnail.image = nil
        rank.reset()
        [title, subtitle].forEach { $0.text = nil }
    }
}
