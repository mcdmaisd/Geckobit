//
//  ThumbnailView.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//

import UIKit
import Kingfisher

final class ThumbnailView: UIImageView {
    init() {
        super.init(frame: .zero)
        self.contentMode = .scaleToFill
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImage(_ url: String) {
        self.kf.setImage(with: URL(string: url))
    }
}
