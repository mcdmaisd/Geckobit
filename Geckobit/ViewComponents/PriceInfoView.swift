//
//  PriceInfoView.swift
//  Geckobit
//
//  Created by ilim on 2025-03-11.
//

import UIKit
import SnapKit

final class PriceInfoView: BaseView {
    private let containerView = UIView()
    private let highPriceTitle = UILabel()
    private let highPriceValue = UILabel()
    private let lowPriceTitle = UILabel()
    private let lowPriceValue = UILabel()
    private let allTimeHighTitle = UILabel()
    private let allTimeHighValue = UILabel()
    private let allTimeHighDate = UILabel()
    private let allTimeLowTitle = UILabel()
    private let allTimeLowValue = UILabel()
    private let allTimeLowDate = UILabel()
    
    override func configureHierarchy() {
        addView(containerView)
        
        containerView.addSubview(highPriceTitle)
        containerView.addSubview(highPriceValue)
        containerView.addSubview(lowPriceTitle)
        containerView.addSubview(lowPriceValue)
        
        containerView.addSubview(allTimeHighTitle)
        containerView.addSubview(allTimeHighValue)
        containerView.addSubview(allTimeHighDate)
        containerView.addSubview(allTimeLowTitle)
        containerView.addSubview(allTimeLowValue)
        containerView.addSubview(allTimeLowDate)
    }
    
    override func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        highPriceTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        highPriceValue.snp.makeConstraints { make in
            make.top.equalTo(highPriceTitle.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        lowPriceTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        lowPriceValue.snp.makeConstraints { make in
            make.top.equalTo(lowPriceTitle.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        allTimeHighTitle.snp.makeConstraints { make in
            make.top.equalTo(highPriceValue.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        
        allTimeHighValue.snp.makeConstraints { make in
            make.top.equalTo(allTimeHighTitle.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        allTimeHighDate.snp.makeConstraints { make in
            make.top.equalTo(allTimeHighValue.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        allTimeLowTitle.snp.makeConstraints { make in
            make.top.equalTo(lowPriceValue.snp.bottom).offset(24)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        allTimeLowValue.snp.makeConstraints { make in
            make.top.equalTo(allTimeLowTitle.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        allTimeLowDate.snp.makeConstraints { make in
            make.top.equalTo(allTimeLowValue.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    override func configureView() {
        containerView.backgroundColor = .customLightgray
        containerView.layer.cornerRadius = 16
        
        highPriceTitle.subtitleLabel(text: "24시간 고가", fontSize: 14)
        lowPriceTitle.subtitleLabel(text: "24시간 저가", fontSize: 14)
        
        allTimeHighTitle.subtitleLabel(text: "역대 최고가", fontSize: 14)
        allTimeLowTitle.subtitleLabel(text: "역대 최저가", fontSize: 14)
    }
    
    func configure(high24h: Double, low24h: Double, ath: Double, athDate: String, atl: Double, atlDate: String) {
        highPriceValue.wonLabel(data: high24h)
        lowPriceValue.wonLabel(data: low24h)
        
        allTimeHighValue.wonLabel(data: ath)
        allTimeHighDate.subtitleLabel(text: Date().iso8601ToString(data: athDate, format: C.alltimeFormat), fontSize: C.small)

        allTimeLowValue.wonLabel(data: atl)
        allTimeLowDate.subtitleLabel(text: Date().iso8601ToString(data: atlDate, format: C.alltimeFormat), fontSize: C.small)
    }
}
