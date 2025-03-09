//
//  TitleView.swift
//  Geckobit
//
//  Created by ilim on 2025-03-09.
//

import UIKit

class TitleView: UILabel {
    init(title: String) {
        super.init(frame: .zero)
        self.text = title
        self.font = .boldSystemFont(ofSize: 20)
        self.textColor = .customNavy
        self.sizeToFit()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
