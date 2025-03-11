//
//  ShowAlert.swift
//  Geckobit
//
//  Created by ilim on 2025-03-11.
//

import UIKit

func showAlert(_ message: String) {
    UIApplication.shared.getCurrentScene().rootViewController?.popAlert(message: message)
}
