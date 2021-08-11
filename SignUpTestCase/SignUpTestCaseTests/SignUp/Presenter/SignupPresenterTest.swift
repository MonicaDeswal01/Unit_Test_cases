//
//  SignupPresenterTest.swift
//  SignUpTestCaseTests
//
//  Created by Monica Mishipay on 11/08/21.
//

import XCTest
@testable import SignUpTestCase

class SignupPresenterTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignUpPresenter_WillValidateEachProperty() {
        let signUpFormModel = SignupFormModel(
            firstName: "Monica",
            lastName: "Deswal",
            email: "test@test.com",
            password: "12345678",
            repeatPassword: "12345678")

        let mockSignUpModelValidator = MockSignupModelValidator()

        let mockSignUPWebService = MockSignUpWebService()
        let mockSignUpViewDelegate = MockSignUpViewDelegate()

        let sut = SignupPresenter(formModelValidator: mockSignUpModelValidator, webservice: mockSignUPWebService, delegte: mockSignUpViewDelegate)
        sut.processUserSignup(formModel: signUpFormModel)

        XCTAssertTrue(mockSignUpModelValidator.isFirstNameValidated)
        XCTAssertTrue(mockSignUpModelValidator.isLastNameValidated)
        XCTAssertTrue(mockSignUpModelValidator.isEmailValidated)
        XCTAssertTrue(mockSignUpModelValidator.isPasswordValidated)
        XCTAssertTrue(mockSignUpModelValidator.isPasswordMatched)
    }

    func testSignUpPresenter_WhenGivenValidFormModel_ShouldCallSignUpMethod() {
        let signUpFormModel = SignupFormModel(
            firstName: "Monica",
            lastName: "Deswal",
            email: "test@test.com",
            password: "12345678",
            repeatPassword: "12345678")

        let mockSignUpModelValidator = MockSignupModelValidator()

        let mockSignUPWebService = MockSignUpWebService()
        let delegate = MockSignUpViewDelegate()

        let sut = SignupPresenter(formModelValidator: mockSignUpModelValidator, webservice: mockSignUPWebService, delegte: delegate)
        sut.processUserSignup(formModel: signUpFormModel)

        XCTAssertTrue(mockSignUPWebService.isSignupMethodCalled, "This method is called when teh signup wedservice ge caaled")

    }

    func testSignupPresenter_WhenSignupOerationCompleted() {
        let myExpectation = self.expectation(description: "Scucessfully finshed the sign up")
        let mockSignUpViewDelegate = MockSignUpViewDelegate()
        mockSignUpViewDelegate.expectation  = myExpectation

        let signUpFormModel = SignupFormModel(
            firstName: "Monica",
            lastName: "Deswal",
            email: "test@test.com",
            password: "12345678",
            repeatPassword: "12345678")
        let mockSignUpModelValidator = MockSignupModelValidator()

        let mockSignUPWebService = MockSignUpWebService()


        let sut = SignupPresenter(formModelValidator: mockSignUpModelValidator, webservice: mockSignUPWebService, delegte: mockSignUpViewDelegate)

        sut.processUserSignup(formModel: signUpFormModel)


        self.wait(for: [myExpectation], timeout: 5)


        XCTAssertEqual(mockSignUpViewDelegate.successfullySignupCounter, 1)
    }

}
