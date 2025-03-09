//
//  TabBar.swift
//  Geckobit
//
//  Created by ilim on 2025-03-06.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        configureTab()
    }
    
    private func configureTab() {
        let tabs = [ExchangeViewController(), CoinInfoViewController(), PortfolioViewController()]
      
        for (i, tab) in tabs.enumerated() {
            tab.tabBarItem = UITabBarItem(
                title: C.tabbarTitles[i],
                image: UIImage(systemName: C.tabbarImages[i]),
                tag: i
            )
        }

        viewControllers = tabs.map { UINavigationController(rootViewController: $0) }
    }
    
    private func configureAppearance() {
        let tabbarAppearance = UITabBarAppearance()
        let itemAppearance = UITabBarItemAppearance()
        
        itemAppearance.normal.iconColor = .customGray
        itemAppearance.selected.iconColor = .customNavy
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customGray]
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customNavy]

        tabbarAppearance.backgroundColor = .white
        tabbarAppearance.stackedLayoutAppearance = itemAppearance
        tabbarAppearance.inlineLayoutAppearance = itemAppearance
        tabbarAppearance.compactInlineLayoutAppearance = itemAppearance
        
        tabBar.standardAppearance = tabbarAppearance
        tabBar.scrollEdgeAppearance = tabbarAppearance
    }
}
