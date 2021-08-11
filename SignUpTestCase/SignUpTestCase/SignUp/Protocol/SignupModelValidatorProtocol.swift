//
//  SignupModelValidatorProtocol.swift
//  SignUpTestCase
//
//  Created by Monica Mishipay on 11/08/21.
//

import Foundation

protocol SignupModelValidatorProtocol {
    func isFirstNameValid(firstName: String) -> Bool
    func isLastNameValid(lastName: String) -> Bool
    func isValidEmailFormat(email: String) -> Bool
    func isPasswordValid(password: String) -> Bool
    func doPasswordMatch(password: String, repeatPassword: String) -> Bool

}
