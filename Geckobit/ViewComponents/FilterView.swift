//
//  FilterView.swift
//  Geckobit
//
//  Created by ilim on 2025-03-09.
//

import UIKit
import SnapKit

final class FilterView: BaseView {
    private(set) var button = UIButton()
    private let arrowContainer = UIStackView()
    private let upArrow = UIImageView()
    private let downArrow = UIImageView()
    
    override func configureHierarchy() {
        addView(button)
        addView(arrowContainer)
        arrowContainer.addArrangedSubview(upArrow)
        arrowContainer.addArrangedSubview(downArrow)
    }
    
    override func configureLayout() {
        button.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
            make.trailing.equalTo(arrowContainer.snp.leading)
        }
        
        arrowContainer.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    override func configureView() {
        button.contentHorizontalAlignment = .trailing
        button.setTitleColor(.customNavy, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        
        arrowContainer.axis = .vertical
        arrowContainer.distribution = .fillEqually
        
        initArrow()
        
        [upArrow, downArrow].forEach { $0.contentMode = .scaleAspectFit }
    }
    
    func initArrow() {
        for (i, name) in C.arrows.enumerated() {
            let arrow = i == 0 ? upArrow : downArrow
            arrow.image = UIImage(systemName: name)
            arrow.tintColor = .customNavy
        }
    }
    
    private func remakeConstraint() {
        button.snp.remakeConstraints { make in
            make.verticalEdges.leading.equalToSuperview()
        }
    }

    func configureData(title: String, tag: Int, isNotFilter: Bool = false) {
        button.setTitle(title, for: .normal)
        button.tag = tag
        
        if isNotFilter {
            remakeConstraint()
            arrowContainer.isHidden = true
        }
    }
    
    func changeArrowColor(status: Sort) {
        switch status {
        case .none:
            break
        case .descending:
            downArrow.image = UIImage(systemName: C.downFill)
            downArrow.tintColor = .black
        case .ascending:
            upArrow.image = UIImage(systemName: C.upFill)
            upArrow.tintColor = .black
        }
    }
}

