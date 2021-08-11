//
//  MockSignUpWebService.swift
//  SignUpTestCaseTests
//
//  Created by Monica Mishipay on 11/08/21.
//

import Foundation
@testable import SignUpTestCase

class MockSignUpWebService: SignupWebServiceProtocol {
    var isSignupMethodCalled: Bool = false
func signup(withForm: SignUpRequestModel, completion: @escaping (SignUpResponseModel?, SignUpError?) -> Void) {

    isSignupMethodCalled = true
    let responseModel = SignUpResponseModel(status: "Ok")
    completion(responseModel,nil)
}


}
