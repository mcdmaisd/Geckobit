//
//  UILabel+.swift
//  Geckobit
//
//  Created by ilim on 2025-03-09.
//

import UIKit

extension UILabel {
    func changeSeparator(text: String) {
        let result = text.replacingOccurrences(of: "-", with: AC.separator)
        self.text = result
    }
    
    func formatPrice(_ value: Double) {
        let roundedValue = (value * 100).rounded() / 100
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let isZero = (roundedValue * 100).truncatingRemainder(dividingBy: 10) == 0
        
        if isZero {
            numberFormatter.maximumFractionDigits = 1
            numberFormatter.minimumFractionDigits = 1
        } else {
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.minimumFractionDigits = 2
        }
        
        let formattedString = numberFormatter.string(from: NSNumber(value: roundedValue)) ?? "0"
        self.text = formattedString
    }

    
    func changeColor(_ data: Double, _ isRate: Bool = true) {
        let textColor: UIColor = data >= 0 ? .customRed : .customBlue
        let percentValue = isRate ? data * 100 : data
        let roundedValue = (percentValue * 100).rounded() / 100

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2

        let formattedValue = numberFormatter.string(from: NSNumber(value: abs(roundedValue))) ?? "0.00"
        
        let signPrefix = (roundedValue != 0 && data < 0) ? "-" : ""
        let suffix = isRate ? "%" : ""
        let result = signPrefix + formattedValue + suffix

        if formattedValue != "0" && formattedValue != "0.00" {
            self.textColor = textColor
        } else {
            self.textColor = .black
        }
        
        self.text = result
    }

    
    func formatVolume(_ data: Double) {
        if data >= C.million {
            let millionValue = Int(data / C.million)
            self.text = "\(millionValue.formatted())\(C.millionSuffix)"
        } else {
            let value = Int(data)
            self.text = value.formatted()
        }
    }
}
