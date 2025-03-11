//
//  Toast.swift
//  Geckobit
//
//  Created by ilim on 2025-03-09.
//

import UIKit
import Toast

func presentToast(_ message: String) {
    var style = ToastStyle()
    
    style.messageColor = .white
    style.backgroundColor = .systemPink
    
    let window = UIApplication.shared.getCurrentScene()
    let center = CGPoint(x: window.bounds.midX, y: window.bounds.midY)
    
    window.hideToast()
    window.makeToast(message, duration: 0.5, point: center, title: nil, image: nil, style: style, completion: nil)
}

func presentLoading() {
    let window = UIApplication.shared.getCurrentScene()
    window.isUserInteractionEnabled = false
    window.makeToastActivity(.center)
}

func hideLoading() {
    let window = UIApplication.shared.getCurrentScene()
    window.isUserInteractionEnabled = true
    window.hideToastActivity()
}
