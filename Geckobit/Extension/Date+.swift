//
//  Date+.swift
//  Geckobit
//
//  Created by ilim on 2025-03-10.
//
import Foundation

extension Date {
    func dateToString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: C.locale)
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    func iso8601ToString(data: String, format: String) -> String {
        let isoformatter = ISO8601DateFormatter()
        isoformatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = isoformatter.date(from: data) else { return C.failureMessage }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: C.locale)
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
}
