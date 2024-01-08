//
//  UserModel.swift
//  ShoeStore
//
//  Created by Nguyễn Khang Hữu on 08/01/2024.
//

import Foundation


struct User: Codable{
    let id : String
    let name: String
    let email: String
    let password: String
}
