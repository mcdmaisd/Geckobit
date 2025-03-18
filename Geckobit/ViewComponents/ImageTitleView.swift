//
//  ImageTitleView.swift
//  Geckobit
//
//  Created by ilim on 2025-03-11.
//

import UIKit

final class ImageTitleView: BaseView {
    private let thumbnailView = ThumbnailView()
    private let symbolView = UILabel()
    
    override func configureHierarchy() {
        addView(thumbnailView)
        addView(symbolView)
    }
    
    override func configureLayout() {
        thumbnailView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
        
        symbolView.snp.makeConstraints { make in
            make.centerY.equalTo(thumbnailView)
            make.leading.equalTo(thumbnailView.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
        }
    }
    
    override func configureView() {
        thumbnailView.contentMode = .scaleAspectFit
        thumbnailView.layer.cornerRadius = 15
    }
    
    func configureData(_ url: String, _ symbol: String) {
        thumbnailView.configureImage(url)
        symbolView.titleLabel(text: symbol.uppercased(), fontSize: C.regular)
    }
}
