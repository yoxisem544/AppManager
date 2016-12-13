//
//  AccessTokenManageable.swift
//  AppManage
//
//  Created by David on 2016/12/13.
//  Copyright © 2016年 David. All rights reserved.
//

import Foundation

protocol AccessTokenManageable {
    
    /// Get token.
    var token: String? { get }
    
    /// Update stored token
    ///
    /// - Parameter token: a string of token
    func update(token: String)
    
    /// Reset token.
    func resetToken()
    
}
