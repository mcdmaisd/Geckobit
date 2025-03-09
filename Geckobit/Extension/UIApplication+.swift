//
//  UIApplication+.swift
//  Geckobit
//
//  Created by ilim on 2025-03-09.
//

import UIKit

extension UIApplication {
    func getCurrentScene() -> UIWindow {
        guard
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let window = windowScene.windows.first
        else { return UIWindow() }
        
        return window
    }
}
