//
//  UIViewController+.swift
//  Geckobit
//
//  Created by ilim on 2025-03-09.
//

import UIKit

extension UIViewController {
    func configureNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.shadowColor = .customGray

        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    func setLeftTitleView(title: String, size: CGFloat) {
        let titleView = TitleView(title: title, size: size)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleView)
    }
    
    func configureLeftBarButtonItem(view: UIView) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
    }
    
    func configureRightBarButtonItem(view: UIView) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
    }
    
    func configureTitleView(view: UIView) {
        navigationItem.titleView = view
    }
}
