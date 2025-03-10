//
//  NFTProfileView.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//

import UIKit

class NFTProfileView: BaseView {
    private let thumbnail = ThumbnailView()
    private let title = UILabel()
    private let subtitle = UILabel()
    private let arrowView = ArrowPercentView()
    
    override func configureHierarchy() {
        addView(thumbnail)
        addView(title)
        addView(subtitle)
        addView(arrowView)
    }
    
    override func configureLayout() {
        thumbnail.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(72)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(thumbnail.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
        }
        
        subtitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
        }
        
        arrowView.snp.makeConstraints { make in
            make.top.equalTo(subtitle.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    override func configureView() {
        thumbnail.layer.cornerRadius = 20
        [title, subtitle].forEach { $0.lineBreakMode = .byTruncatingTail }
    }
    
    func configureProfile(_ data: NFTItem) {
        thumbnail.configureImage(data.thumb)
        title.titleLabel(text: data.name, fontSize: C.small, true)
        subtitle.subtitleLabel(text: data.data.floor_price, fontSize: C.small, true)
        arrowView.configureButton(data.floor_price_24h_percentage_change, true)
    }
    
    func reset() {
        thumbnail.image = nil
        arrowView.reset()
        [title, subtitle].forEach { $0.text = nil }
    }
}

