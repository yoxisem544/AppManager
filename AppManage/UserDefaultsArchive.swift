//
//  UserDefaultsArchive.swift
//  UserDefaults
//
//  Created by David on 2016/12/13.
//  Copyright © 2016年 David. All rights reserved.
//

import Foundation

// MARK: - Archiving custom types

// MARK: RawRepresentable, for enum

extension UserDefaults {
    // TODO: Ensure that T.RawValue is compatible
    public func archive<T: RawRepresentable>(_ key: DefaultsKey<T>, _ value: T) {
        set(key, value.rawValue)
    }
    
    public func archive<T: RawRepresentable>(_ key: DefaultsKey<T?>, _ value: T?) {
        if let value = value {
            set(key, value.rawValue)
        } else {
            remove(key: key)
        }
    }
    
    public func unarchive<T: RawRepresentable>(_ key: DefaultsKey<T?>) -> T? {
        return object(forKey: key.rawString).flatMap { T(rawValue: $0 as! T.RawValue) }
    }
    
    public func unarchive<T: RawRepresentable>(_ key: DefaultsKey<T>) -> T? {
        return object(forKey: key.rawString).flatMap { T(rawValue: $0 as! T.RawValue) }
    }
}

// MARK: NSCoding, for any class conform to NSCoding
extension UserDefaults {
    
    public func archive<T: NSCoding>(_ key: DefaultsKey<T>, _ value: T) {
        set(key, NSKeyedArchiver.archivedData(withRootObject: value))
    }
    
    public func archive<T: NSCoding>(_ key: DefaultsKey<T?>, _ value: T?) {
        if let value = value {
            set(key, NSKeyedArchiver.archivedData(withRootObject: value))
        } else {
            remove(key: key)
        }
    }
    
    public func unarchive<T: NSCoding>(_ key: DefaultsKey<T>) -> T? {
        return data(forKey: key.rawString).flatMap { NSKeyedUnarchiver.unarchiveObject(with: $0) } as? T
    }
    
    public func unarchive<T: NSCoding>(_ key: DefaultsKey<T?>) -> T? {
        return data(forKey: key.rawString).flatMap { NSKeyedUnarchiver.unarchiveObject(with: $0) } as? T
    }
}
