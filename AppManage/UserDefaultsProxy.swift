//
//  UserDefaultsProxy.swift
//  UserDefaults
//
//  Created by David on 2016/12/13.
//  Copyright © 2016年 David. All rights reserved.
//

import Foundation

public let Defaults = UserDefaults.standard

public extension UserDefaults {
    
    public class Proxy {
        fileprivate let defaults: UserDefaults
        fileprivate let key: String
        
        fileprivate init(_ defaults: UserDefaults, _ key: String) {
            self.defaults = defaults
            self.key = key
        }
        
        // MAKR: Getters
        
        public var object: Any? {
            return defaults.object(forKey: key)
        }
        
        public var string: String? {
            return defaults.string(forKey: key)
        }
        
        public var array: [Any]? {
            return defaults.array(forKey: key)
        }
        
        public var dictionary: [String: Any]? {
            return defaults.dictionary(forKey: key)
        }
        
        public var data: Data? {
            return defaults.data(forKey: key)
        }
        
        public var date: Date? {
            return object as? Date
        }
        
        public var number: NSNumber? {
            return defaults.number(forKey: key)
        }
        
        public var int: Int? {
            return number?.intValue
        }
        
        public var double: Double? {
            return number?.doubleValue
        }
        
        public var bool: Bool? {
            return number?.boolValue
        }
        
        // MARK: Non-Optional Getters
        
        public var stringValue: String {
            return string ?? ""
        }
        
        public var arrayValue: [Any] {
            return array ?? []
        }
        
        public var dictionaryValue: [String: Any] {
            return dictionary ?? [:]
        }
        
        public var dataValue: Data {
            return data ?? Data()
        }
        
        public var numberValue: NSNumber {
            return number ?? 0
        }
        
        public var intValue: Int {
            return int ?? 0
        }
        
        public var doubleValue: Double {
            return double ?? 0
        }
        
        public var boolValue: Bool {
            return bool ?? false
        }
        
    }
    
    public subscript(key: String) -> Proxy {
        return Proxy(self, key)
    }
    
}
