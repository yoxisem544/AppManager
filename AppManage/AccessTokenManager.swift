//
//  AccessTokenManager.swift
//  AppManage
//
//  Created by David on 2016/12/13.
//  Copyright © 2016年 David. All rights reserved.
//

import Foundation
import KeychainAccess

final public class AccessTokenManager {
    
    fileprivate let keychain: Keychain = Keychain()
    fileprivate var tokenKey: String { return "unique_token_key" }
    
    private init() {}
    
    @discardableResult
    public class func shared() -> AccessTokenManager {
        
        struct Static {
            static let instance: AccessTokenManager = AccessTokenManager()
        }
        
        return Static.instance
    }
    
}

extension AccessTokenManager : AccessTokenManageable {
    
    public var token: String? { return keychain[tokenKey] }
    
    public func update(token: String) {
        keychain[tokenKey] = token
    }
    
    public func resetToken() {
        keychain[tokenKey] = nil
    }
    
}
