//
//  UserDefaultsManager.swift
//  Geckobit
//
//  Created by ilim on 2025-03-18.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    
    private init() { }
    
    func set(_ value: Any, _ key: String) {
        defaults.setValue(value, forKey: key)
    }
    
    func get<T>(_ key: String, _ defaultValue: T) -> T {
        defaults.object(forKey: key) as? T ?? defaultValue
    }
}
