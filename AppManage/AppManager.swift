//
//  AppManager.swift
//  AppManage
//
//  Created by David on 2016/12/13.
//  Copyright © 2016年 David. All rights reserved.
//

import Foundation

final public class AppManager {
    
    private init() {}
    
    @discardableResult
    public class func shared() -> AppManager {
        
        struct Static {
            static let instance: AppManager = AppManager()
        }
        
        return Static.instance
    }
    
}

extension AppManager : AppManageable {
    
    public var tokenManger: AccessTokenManager { return AccessTokenManager.shared() }
    
    public var user: UserInformation { return UserInformation.shared() }
    
    public var isLoggedIn: Bool {
        return false
    }
    
}
