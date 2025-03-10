//
//  TitleView.swift
//  Geckobit
//
//  Created by ilim on 2025-03-09.
//

import UIKit

class TitleView: UILabel {
    init(title: String, size: CGFloat) {
        super.init(frame: .zero)
        self.text = title
        self.font = .boldSystemFont(ofSize: size)
        self.textColor = .customNavy
        self.sizeToFit()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
