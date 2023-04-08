//
//  UserEntry.swift
//  Bitcamp2023
//
//  Created by Gerdin Ventura on 4/7/23.
//

import Foundation

struct UserEntry: Codable, Hashable {
    let uid: String
    let fullname: String
    let username: String
    let email: String
    let lists: [String] // list_id
}
