//
//  UserDefaultsSubscripts.swift
//  UserDefaults
//
//  Created by David on 2016/12/13.
//  Copyright © 2016年 David. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func number(forKey key: String) -> NSNumber? {
        return object(forKey: key) as? NSNumber
    }
    
    public subscript(key: String) -> Any? {
        get {
            // return untyped Proxy
            // (make sure we don't fall into infinite loop)
            let proxy: Proxy = self[key]
            return proxy
        }
        set {
            guard let newValue = newValue else {
                self.removeObject(forKey: key)
                return
            }
            
            switch newValue {
                // @warning This should always be on top of Int because a cast
            // from Double to Int will always succeed.
            case let v as Double: self.set(v, forKey: key)
            case let v as Int: self.set(v, forKey: key)
            case let v as Bool: self.set(v, forKey: key)
            case let v as URL: self.set(v, forKey: key)
            default: self.set(newValue, forKey: key)
            }
            
        }
    }
    
    /// Check if key does exists
    public func hasKey(_ key: String) -> Bool {
        return object(forKey: key) != nil
    }
    
    public func remove(key: String) {
        removeObject(forKey: key)
    }
    
    public func removeAll() {
        dictionaryRepresentation().forEach { removeObject(forKey: $0.key) }
    }
    
}

extension UserDefaults {
    /// This function allows you to create your own custom Defaults subscript. Example: [Int: String]
    public func set<T>(_ key: DefaultsKey<T>, _ value: Any?) {
        self[key.rawString] = value
    }
}

extension UserDefaults {
    /// Returns `true` if `key` exists
    
    public func hasKey<T>(_ key: DefaultsKey<T>) -> Bool {
        return object(forKey: key.rawString) != nil
    }
    
    /// Removes value for `key`
    
    public func remove<T>(key: DefaultsKey<T>) {
        removeObject(forKey: key.rawString)
    }
}

// MARK: Subscripts for specific standard types

// TODO: Use generic subscripts when they become available

extension UserDefaults {
    public subscript(key: DefaultsKey<String?>) -> String? {
        get { return string(forKey: key.rawString) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<String>) -> String {
        get { return string(forKey: key.rawString) ?? "" }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Int?>) -> Int? {
        get { return number(forKey: key.rawString)?.intValue }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Int>) -> Int {
        get { return number(forKey: key.rawString)?.intValue ?? 0 }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Double?>) -> Double? {
        get { return number(forKey: key.rawString)?.doubleValue }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Double>) -> Double {
        get { return number(forKey: key.rawString)?.doubleValue ?? 0.0 }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Bool?>) -> Bool? {
        get { return number(forKey: key.rawString)?.boolValue }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Bool>) -> Bool {
        get { return number(forKey: key.rawString)?.boolValue ?? false }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Any?>) -> Any? {
        get { return object(forKey: key.rawString) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Data?>) -> Data? {
        get { return data(forKey: key.rawString) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Data>) -> Data {
        get { return data(forKey: key.rawString) ?? Data() }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<Date?>) -> Date? {
        get { return object(forKey: key.rawString) as? Date }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<URL?>) -> URL? {
        get { return url(forKey: key.rawString) }
        set { set(key, newValue) }
    }
    
    // TODO: It would probably make sense to have support for statically typed dictionaries (e.g. [String: String])
    
    public subscript(key: DefaultsKey<[String: Any]?>) -> [String: Any]? {
        get { return dictionary(forKey: key.rawString) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[String: Any]>) -> [String: Any] {
        get { return dictionary(forKey: key.rawString) ?? [:] }
        set { set(key, newValue) }
    }
}

// MARK: Static subscripts for array types

extension UserDefaults {
    public subscript(key: DefaultsKey<[Any]?>) -> [Any]? {
        get { return array(forKey: key.rawString) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Any]>) -> [Any] {
        get { return array(forKey: key.rawString) ?? [] }
        set { set(key, newValue) }
    }
}

// We need the <T: AnyObject> and <T: _ObjectiveCBridgeable> variants to
// suppress compiler warnings about NSArray not being convertible to [T]
// AnyObject is for NSData and NSDate, _ObjectiveCBridgeable is for value
// types bridge-able to Foundation types (String, Int, ...)

extension UserDefaults {
    public func getArray<T: _ObjectiveCBridgeable>(_ key: DefaultsKey<[T]>) -> [T] {
        return array(forKey: key.rawString) as NSArray? as? [T] ?? []
    }
    
    public func getArray<T: _ObjectiveCBridgeable>(_ key: DefaultsKey<[T]?>) -> [T]? {
        return array(forKey: key.rawString) as NSArray? as? [T]
    }
    
    public func getArray<T: Any>(_ key: DefaultsKey<[T]>) -> [T] {
        return array(forKey: key.rawString) as NSArray? as? [T] ?? []
    }
    
    public func getArray<T: Any>(_ key: DefaultsKey<[T]?>) -> [T]? {
        return array(forKey: key.rawString) as NSArray? as? [T]
    }
}

extension UserDefaults {
    public subscript(key: DefaultsKey<[String]?>) -> [String]? {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[String]>) -> [String] {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Int]?>) -> [Int]? {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Int]>) -> [Int] {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Double]?>) -> [Double]? {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Double]>) -> [Double] {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Bool]?>) -> [Bool]? {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Bool]>) -> [Bool] {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Data]?>) -> [Data]? {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Data]>) -> [Data] {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Date]?>) -> [Date]? {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
    
    public subscript(key: DefaultsKey<[Date]>) -> [Date] {
        get { return getArray(key) }
        set { set(key, newValue) }
    }
}
