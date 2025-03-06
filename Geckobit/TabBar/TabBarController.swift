//
//  TabBar.swift
//  MyMDB
//
//  Created by ilim on 2025-01-25.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabs = [ExchangeViewController(), CoinInfoViewController(), PortfolioViewController()]
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
        
        for (i, tab) in tabs.enumerated() {
            tab.tabBarItem = UITabBarItem(
                title: C.tabbarTitles[i],
                image: UIImage(systemName: C.tabbarImages[i]),
                tag: i
            )
        }

        viewControllers = tabs.map { UINavigationController(rootViewController: $0) }
    }
}
