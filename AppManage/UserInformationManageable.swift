//
//  UserInformationManageable.swift
//  AppManage
//
//  Created by David on 2016/12/13.
//  Copyright © 2016年 David. All rights reserved.
//

import Foundation

public protocol UserInformationManageable {
    
    var id: Int? { get set }
    var name: String? { get set }
    var facebookID: Double? { get set }
    var organization: String? { get set }
    var department: String? { get set }
    var email: String? { get set }
    
}
