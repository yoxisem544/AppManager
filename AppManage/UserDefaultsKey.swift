//
//  UserDefaultsKey.swift
//  UserDefaults
//
//  Created by David on 2016/12/13.
//  Copyright © 2016年 David. All rights reserved.
//

import Foundation

/// Extend this class and add your user defaults keys as static constants
/// so you can use the shortcut dot notation (e.g. `Defaults[.yourKey]`)
public class DefaultsKeys {
    fileprivate init() {}
}

/// Base class for static user defaults keys. Specialize with value type
/// and pass key name to the initializer to create a key.
public class DefaultsKey<ValueType>: DefaultsKeys {
    // TODO: Can we use protocols to ensure ValueType is a compatible type?
    public let rawString: String
    
    public init(_ key: String) {
        self.rawString = key
        super.init()
    }

}
