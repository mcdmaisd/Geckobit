//
//  InvestmentView.swift
//  Geckobit
//
//  Created by ilim on 2025-03-11.
//

import UIKit
import SnapKit

final class InvestmentView: BaseView {
    private let containerView = UIView()
    private let marketCapTitle = UILabel()
    private let marketCapValue = UILabel()
    private let fdvTitle = UILabel()
    private let fdvValue = UILabel()
    private let volumeTitle = UILabel()
    private let volumeValue = UILabel()
    
    override func configureHierarchy() {
        addView(containerView)
        containerView.addSubview(marketCapTitle)
        containerView.addSubview(marketCapValue)
        containerView.addSubview(fdvTitle)
        containerView.addSubview(fdvValue)
        containerView.addSubview(volumeTitle)
        containerView.addSubview(volumeValue)
    }
    
    override func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        marketCapTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        marketCapValue.snp.makeConstraints { make in
            make.top.equalTo(marketCapTitle.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        fdvTitle.snp.makeConstraints { make in
            make.top.equalTo(marketCapValue.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        fdvValue.snp.makeConstraints { make in
            make.top.equalTo(fdvTitle.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        volumeTitle.snp.makeConstraints { make in
            make.top.equalTo(fdvValue.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        volumeValue.snp.makeConstraints { make in
            make.top.equalTo(volumeTitle.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    override func configureView() {
        containerView.backgroundColor = .customLightgray
        containerView.layer.cornerRadius = 16
        
        marketCapTitle.subtitleLabel(text: "시가총액", fontSize: 14)
        fdvTitle.subtitleLabel(text: "완전 희석 가치(FDV)", fontSize: 14)
        volumeTitle.subtitleLabel(text: "총 거래량", fontSize: 14)
    }
    
    func configure(marketCap: Double, fdv: Double, volume: Double) {
        marketCapValue.wonLabel(data: marketCap)
        fdvValue.wonLabel(data: fdv)
        volumeValue.wonLabel(data: volume)
    }
}
