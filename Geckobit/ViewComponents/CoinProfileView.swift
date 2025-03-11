//
//  CoinProfileWithRank.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//

import UIKit

final class CoinProfileView: BaseView {
    private let thumbnail = ThumbnailView()
    private let title = UILabel()
    private let subtitle = UILabel()
    private let arrowView = ArrowPercentView()
    private let index = UILabel()

    override func configureHierarchy() {
        addView(index)
        addView(thumbnail)
        addView(title)
        addView(subtitle)
        addView(arrowView)
    }
    
    override func configureLayout() {
        index.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.width.equalTo(12)
        }

        thumbnail.snp.makeConstraints { make in
            make.leading.equalTo(index.snp.trailing).offset(3)
            make.verticalEdges.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(26)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(thumbnail)
            make.leading.equalTo(thumbnail.snp.trailing).offset(5)
            make.trailing.equalTo(arrowView.snp.leading)
        }
        
        subtitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom)
            make.leading.equalTo(title)
            make.trailing.equalTo(arrowView.snp.leading)
        }
        
        arrowView.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
            make.width.equalTo(70)
        }
    }
    
    override func configureView() {
        [title, subtitle].forEach { $0.lineBreakMode = .byTruncatingTail }
        thumbnail.layer.cornerRadius = 13
        index.font = .systemFont(ofSize: 9)
    }
        
    func configureProfile(_ data: CoinItemDetail, _ row: Int) {
        thumbnail.configureImage(data.thumb)
        title.titleLabel(text: data.symbol, fontSize: C.medium)
        subtitle.subtitleLabel(text: data.name, fontSize: C.small)
        arrowView.configureButton(data.data.price_change_percentage_24h.krw)
        index.text = "\(row + 1)"
    }
}
