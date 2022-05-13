//
//  UserModel.swift
//  NutriPal (iOS)
//
//  Created by Jessie Pao on 5/9/22.
//

import Foundation

// model for the user email and name
struct UserModel: Decodable, Hashable {
    var uid: String
    var email: String
    var name: String
}
