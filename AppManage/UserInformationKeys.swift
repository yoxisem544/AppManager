//
//  UserInformationKeys.swift
//  AppManage
//
//  Created by David on 2016/12/13.
//  Copyright © 2016年 David. All rights reserved.
//

import Foundation

private struct UserInformationKeys {
    static let id = "UserInformationKey id"
    static let name = "UserInformationKey name"
    static let facebookID = "UserInformationKey facebookID"
    static let organization = "UserInformationKey organization"
    static let department = "UserInformationKey department"
    static let email = "UserInformationKey email"
}

extension DefaultsKeys {
    static let id = DefaultsKey<Int?>(UserInformationKeys.id)
    static let name = DefaultsKey<String?>(UserInformationKeys.name)
    static let facebookID = DefaultsKey<Double?>(UserInformationKeys.facebookID)
    static let organization = DefaultsKey<String?>(UserInformationKeys.organization)
    static let department = DefaultsKey<String?>(UserInformationKeys.department)
    static let email = DefaultsKey<String?>(UserInformationKeys.email)
}
