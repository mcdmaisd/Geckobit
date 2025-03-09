//
//  HeaderView.swift
//  Geckobit
//
//  Created by ilim on 2025-03-09.
//

import UIKit

final class ContainerView: UIStackView {
    init(backgroundColor: UIColor? = nil) {
        super.init(frame: .zero)
        configureStackView()
        
        if let backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStackView() {
        axis = .horizontal
        distribution = .fillEqually
    }
}
