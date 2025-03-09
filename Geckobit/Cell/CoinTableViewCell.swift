//
//  CoinTableViewCell.swift
//  Geckobit
//
//  Created by ilim on 2025-03-09.
//

import UIKit

final class CoinTableViewCell: BaseTableViewCell {
    private let containerView = ContainerView()
    private let changeContainerView = UIStackView()
    private let coinName = UILabel()
    private let currentPrice = UILabel()
    private let priceChangeRate = UILabel()
    private let priceChange = UILabel()
    private let tradePriceSum = UILabel()
    
    override func configureHierarchy() {
        addSubview(containerView)
        changeContainerView.addArrangedSubview(priceChangeRate)
        changeContainerView.addArrangedSubview(priceChange)
        containerView.addArrangedSubview(coinName)
        containerView.addArrangedSubview(currentPrice)
        containerView.addArrangedSubview(changeContainerView)
        containerView.addArrangedSubview(tradePriceSum)
    }
    
    override func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(5)
        }
    }
    
    override func configureView() {
        changeContainerView.axis = .vertical
        changeContainerView.spacing = 0
        changeContainerView.distribution = .fillProportionally
        
        coinName.font = .systemFont(ofSize: C.medium, weight: .bold)
        coinName.textAlignment = .left
        
        [currentPrice, priceChangeRate, tradePriceSum].forEach {
            $0.font = .systemFont(ofSize: C.medium, weight: .regular)
            $0.textAlignment = .right
        }
        
        priceChange.font = .systemFont(ofSize: C.small, weight: .regular)
        priceChange.textAlignment = .right
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [coinName, currentPrice, priceChange, priceChangeRate, tradePriceSum].forEach { $0.text = nil }
    }
    
    func configureData(_ data: UpbitResponse) {
        coinName.changeSeparator(text: data.market)
        currentPrice.formatPrice(data.trade_price)
        priceChangeRate.changeColor(data.signed_change_rate)
        priceChange.changeColor(data.signed_change_price, false)
        tradePriceSum.formatVolume(data.acc_trade_price_24h)
    }
}
