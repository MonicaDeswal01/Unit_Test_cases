//
//  MockSignupModelValidator.swift
//  SignUpTestCaseTests
//
//  Created by Monica Mishipay on 11/08/21.
//

import Foundation
@testable import SignUpTestCase

class MockSignupModelValidator: SignupModelValidatorProtocol{
    var isFirstNameValidated: Bool = false
    var isLastNameValidated: Bool = false
    var isEmailValidated: Bool = false
    var isPasswordValidated: Bool = false
    var isPasswordMatched: Bool = false

    func isFirstNameValid(firstName: String) -> Bool {
        isFirstNameValidated = true
        return isFirstNameValidated
    }
    func isLastNameValid(lastName: String) -> Bool {
        isLastNameValidated = true
        return true
    }

    func isValidEmailFormat(email: String) -> Bool {
        isEmailValidated = true
        return isEmailValidated
    }

    func isPasswordValid(password: String) -> Bool {
        isPasswordValidated = true
        return isPasswordValidated
    }

    func doPasswordMatch(password: String, repeatPassword: String) -> Bool {
        isPasswordMatched = true
        return isPasswordMatched
    }

    
}
