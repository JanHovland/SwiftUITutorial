//
//  UserDefaultsPropertyWrapper.swift
//  SwiftUITutorial
//
//  Created by Jan Hovland on 14/04/2020.
//  Copyright © 2020 Jan Hovland. All rights reserved.
//

// from https://www.avanderlee.com/swift/property-wrappers/

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

