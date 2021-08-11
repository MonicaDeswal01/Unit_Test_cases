//
//  SignUpWebServiceTestCase.swift
//  SignUpTestCaseTests
//
//  Created by Monica Mishipay on 11/08/21.
//

import XCTest
@testable import SignUpTestCase

class SignUpWebServiceTestCase: XCTestCase {

    override class func tearDown() {
        MockURLProtocol.stubResponseData = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignUpService_ReceiveSuccessResponse() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let jsonString =  "{\"status\":\"ok\"}"
        
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)


        let webService = SignUpWebService(urlString: SignUpConstants.signUpUrl, urlSession: urlSession)

        let signUpRequestModel = SignUpRequestModel(
            firstName: "Monica",
            lastName: "Deswal",
            email: "test@test.com",
            password: "123456789")

        let expectation = self.expectation(description: "Sign Up web service response expectation")

        webService.signup(withForm : signUpRequestModel) { (signUpResponseModel, errorObject) in
            XCTAssertEqual(signUpResponseModel?.status, "ok")
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 5)
    }

    func testSignUpService_ReceivedDifferentJSONResponse_ErrorReceived() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let jsonString = "{\"error\":\"Internal Server response\"}"

        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)

        let webService = SignUpWebService(urlString: SignUpConstants.signUpUrl, urlSession: urlSession)

        let signUpRequestModel = SignUpRequestModel(
            firstName: "Monica",
            lastName: "Deswal",
            email: "test@test.com",
            password: "123456789")

        let expectation = self.expectation(description: "Expectation for error received in signup")
        webService.signup(withForm: signUpRequestModel) { signUpResponseModel, errorObject in
            XCTAssertNil(signUpResponseModel, "Response model should be nil for the not matching error response")
            XCTAssertEqual(errorObject, SignUpError.responseModelParsingError)

            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 5)

    }

    func testSignUpService_WhenBlankIsPassed_ReceiveErrorMessage() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)

        let webService = SignUpWebService(urlString: "", urlSession: urlSession)

        let signUpRequestModel = SignUpRequestModel(
            firstName: "Monica",
            lastName: "Deswal",
            email: "test@test.com",
            password: "123456789")

        let expectation = self.expectation(description: "Receive the error when the blank url is passed")
        webService.signup(withForm: signUpRequestModel) { signUpResponseModel, errorObject in
            XCTAssertNil(signUpResponseModel, "Request is not fulfilled due to blank request")
            XCTAssertEqual(errorObject, SignUpError.invalidURLStringError)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)

    }

    func testSignUpService_ReceiveTheErrorMessageInResponse() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let errorDescription = "A localised error description of an error"
        MockURLProtocol.error = SignUpError.failedRequest(description: errorDescription)

        let webService = SignUpWebService(urlString: SignUpConstants.signUpUrl, urlSession: urlSession)

        let signUpRequestModel = SignUpRequestModel(
            firstName: "Monica",
            lastName: "Deswal",
            email: "test@test.com",
            password: "123456789")

        let expectation = self.expectation(description: "Expectation for error received in signup")
        webService.signup(withForm: signUpRequestModel) { signUpResponseModel, errorObject in
            XCTAssertEqual(errorObject, SignUpError.failedRequest(description: errorDescription))

            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 5)


/**

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        let errorDescription = "A localised error description of an error"
        MockURLProtocol.error = SignUpError.failedRequest(description: errorDescription)

        let webService = SignUpWebService(urlString: SignUpConstants.signUpUrl, urlSession: urlSession)

        let signUpRequestModel = SignUpRequestModel(
            firstName: "Monica",
            lastName: "Deswal",
            email: "test@test.com",
            password: "123456789")

        let expectation = self.expectation(description: "Error message is received in response")



        webService.signup(withForm: signUpRequestModel) { SignUpResponseModel, errorObject in

            XCTAssertEqual(errorObject, SignUpError.failedRequest(description: errorDescription))
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 5)
 **/
    }

}
