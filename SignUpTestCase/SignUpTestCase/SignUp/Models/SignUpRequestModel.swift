//
//  SignUpRequestModel.swift
//  SignUpTestCase
//
//  Created by Monica Mishipay on 11/08/21.
//

import Foundation

struct SignUpRequestModel: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
