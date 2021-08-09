//
//  UserDetailsModel.swift
//  IntegrationTest
//
//  Created by Monica Mishipay on 09/08/21.
//

import Foundation

struct UserDetailsModel: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
