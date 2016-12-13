//
//  AppManageable.swift
//  AppManage
//
//  Created by David on 2016/12/13.
//  Copyright © 2016年 David. All rights reserved.
//

import Foundation

public protocol AppManageable {
    
    var tokenManger: AccessTokenManager { get }
    
    /// Do all things with user' information
    var user: UserInformation { get }
    
    /// To check user is logged in.
    var isLoggedIn: Bool { get }
    
}
