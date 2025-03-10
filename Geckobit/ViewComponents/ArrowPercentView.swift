//
//  ArrowPercentView.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//

import UIKit

final class ArrowPercentView: BaseView {
    private let button = UIButton()
    
    override func configureHierarchy() {
        addView(button)
    }
    
    override func configureLayout() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        button.isUserInteractionEnabled = false
    }

    func configureButton(_ change: Double, _ isCenter: Bool = false) {
        let roundedValue = (change * 100).rounded() / 100
        let formattedValue = String(format: "%.2f", abs(roundedValue))
        let isMinus = roundedValue < 0
        let isZero = roundedValue == 0
        let imageName = isMinus ? C.downFill : C.upFill
        let foregroundColor: UIColor = isZero ? .customNavy : (isMinus ? .customBlue : .customRed)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: C.small)

        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.systemFont(ofSize: C.small, weight: .bold)
        
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = foregroundColor
        config.preferredSymbolConfigurationForImage = imageConfig
        config.image = isZero ? nil : UIImage(systemName: imageName)
        config.imagePadding = 2
        config.attributedTitle = AttributedString(formattedValue + "%", attributes: titleContainer)
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        button.configuration = config
        button.contentHorizontalAlignment = isCenter ? .center : .trailing
    }
    
    func reset() {
        button.configuration = UIButton.Configuration.plain()
    }
}
