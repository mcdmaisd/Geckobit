//
//  UILabel+.swift
//  Geckobit
//
//  Created by ilim on 2025-03-09.
//

import UIKit

extension UILabel {
    private static let decimalFormatter: NumberFormatter = {
         let formatter = NumberFormatter()
         formatter.numberStyle = .decimal
         return formatter
     }()
    
    func changeSeparator(text: String) {
        let result = text.replacingOccurrences(of: "-", with: AC.separator)
        self.text = result
    }
    
    func formatPrice(_ value: Double) {
        let roundedValue = (value * 100).rounded() / 100
        let isZero = (roundedValue * 100).truncatingRemainder(dividingBy: 10) == 0
        let formatter = UILabel.decimalFormatter
        
        if isZero {
            formatter.maximumFractionDigits = 1
            formatter.minimumFractionDigits = 1
        } else {
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
        }
        
        let formattedString = formatter.string(from: NSNumber(value: roundedValue)) ?? "0"
        self.text = formattedString
    }

    func changeColor(_ data: Double, _ isRate: Bool = true) {
        let textColor: UIColor = data >= 0 ? .customRed : .customBlue
        let percentValue = isRate ? data * 100 : data
        let roundedValue = (percentValue * 100).rounded() / 100
        let formatter = UILabel.decimalFormatter

        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        let formattedValue = formatter.string(from: NSNumber(value: abs(roundedValue))) ?? "0.00"
        
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
