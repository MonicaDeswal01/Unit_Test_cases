//
//  SignupFormModelValidator.swift
//  SignUpTestCase
//
//  Created by Monica Mishipay on 11/08/21.
//

import Foundation

class SignupFormModelValidator: SignupModelValidatorProtocol {
    func isFirstNameValid(firstName: String) -> Bool {
        var returnValue = true

        if firstName.count < SignUpConstants.firstNameMinLength ||
            firstName.count > SignUpConstants.firstNameMaxLength {
            returnValue = false
        }
        return returnValue
    }

    func isLastNameValid(lastName: String) -> Bool {
        var returnValue = true

        if lastName.count < SignUpConstants.lastNameMinLength ||
            lastName.count > SignUpConstants.lastNameMaxLength {
            returnValue = false
        }
        return returnValue
    }

    func isValidEmailFormat(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
    }

    func isPasswordValid(password: String) -> Bool {
        var returnValue = true

        if password.count < SignUpConstants.passwordMinLength ||
            password.count > SignUpConstants.passwordMaxLength {
            returnValue = false
        }
        return returnValue
    }

    func doPasswordMatch(password: String, repeatPassword: String) -> Bool {
        return password == repeatPassword
    }

}
