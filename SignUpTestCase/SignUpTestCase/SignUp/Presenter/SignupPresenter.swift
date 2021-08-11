//
//  SignupPresenter.swift
//  SignUpTestCase
//
//  Created by Monica Mishipay on 11/08/21.
//

import Foundation

class SignupPresenter {

    private let formModelValidator: SignupModelValidatorProtocol
    private var webService: SignupWebServiceProtocol
    private var delegte: SignUpViewDelegateProtocol?

    init(formModelValidator: SignupModelValidatorProtocol, webservice: SignupWebServiceProtocol, delegte: SignUpViewDelegateProtocol) {
        self.formModelValidator = formModelValidator
        self.webService = webservice
        self.delegte = delegte
    }

    func processUserSignup(formModel: SignupFormModel) {
        if !formModelValidator.isFirstNameValid(firstName: formModel.firstName) {
            return
        }

        if !formModelValidator.isLastNameValid(lastName: formModel.lastName) {
            return
        }

        if !formModelValidator.isValidEmailFormat(email: formModel.email) {
            return
        }

        if !formModelValidator.isPasswordValid(password: formModel.password) {
            return
        }

        if !formModelValidator.doPasswordMatch(password: formModel.password, repeatPassword: formModel.repeatPassword) {
            return
        }

        let requestModel = SignUpRequestModel(
            firstName: formModel.firstName,
            lastName: formModel.lastName,
            email: formModel.email,
            password: formModel.password)

        webService.signup(withForm: requestModel) { [weak self ](responseModel, error) in
            guard let self = self else { return }

            if let _ = responseModel {
                self.delegte?.successfullySignUp()
            }
        }

    }
}
