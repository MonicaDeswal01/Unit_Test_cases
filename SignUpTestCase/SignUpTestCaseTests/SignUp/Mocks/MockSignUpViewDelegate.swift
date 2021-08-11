//
//  MockSignUpViewDelegate.swift
//  SignUpTestCaseTests
//
//  Created by Monica Mishipay on 11/08/21.
//

import Foundation
import XCTest
@testable import SignUpTestCase

class MockSignUpViewDelegate: SignUpViewDelegateProtocol {
    var expectation: XCTestExpectation?
    var successfullySignupCounter = 0

    func successfullySignUp() {
        successfullySignupCounter += 1
        expectation?.fulfill()
    }

    func errorHandler(error: SignUpError) {
        
    }


}
