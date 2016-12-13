//
//  UserInformation.swift
//  AppManage
//
//  Created by David on 2016/12/13.
//  Copyright © 2016年 David. All rights reserved.
//

import Foundation

final public class UserInformation {
    
    private init() {}
    
    @discardableResult
    public class func shared() -> UserInformation {
        
        struct Static {
            static let instance: UserInformation = UserInformation()
        }
        
        return Static.instance
    }
    
}

extension UserInformation : UserInformationManageable {
    
    public var id: Int? {
        get { return Defaults[.id] }
        set { Defaults[.id] = newValue }
    }
    
    public var name: String? {
        get { return Defaults[.name] }
        set { Defaults[.name] = newValue }
    }
    
    public var facebookID: Double? {
        get { return Defaults[.facebookID] }
        set { Defaults[.facebookID] = newValue }
    }
    
    public var organization: String? {
        get { return Defaults[.organization] }
        set { Defaults[.organization] = newValue }
    }
    
    public var department: String? {
        get { return Defaults[.department] }
        set { Defaults[.department] = newValue }
    }
    
    public var email: String? {
        get { return Defaults[.email] }
        set { Defaults[.email] = newValue }
    }
    
}
