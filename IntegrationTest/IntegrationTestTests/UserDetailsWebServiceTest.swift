//
//  UserDetailsWebServiceTest.swift
//  IntegrationTestTests
//
//  Created by Monica Mishipay on 09/08/21.
//

import XCTest
@testable import IntegrationTest

class UserDetailsWebServiceTest: XCTestCase {

    var sut: UserDetailsWebService! = nil

    override func setUp() {

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        self.sut = UserDetailsWebService(urlString: userDetailsURL, urlSession: urlSession)
    }

    override class func tearDown() {
       // self.sut = nil
        MockURLProtocol.stubResponseData = nil
    }
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApiResponseSuccessful() {


        let jsonData = "{\"userId\":1,\"id\":1,\"title\":\"delectus aut autem\",\"completed\":false}".data(using: .utf8)
        MockURLProtocol.stubResponseData = jsonData
        let expectation = self.expectation(description: "User details request")

        sut.requestTheUserDetails { userDetailsModel, errorObject in
            XCTAssertNotNil(userDetailsModel?.id)
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 5)
    }

    func testApiResponseFailureWhenReceiveUnknownJSON() {

        let jsonData = "{\"error\":\"internal server error\"}".data(using: .utf8)
        MockURLProtocol.stubResponseData = jsonData
        let expectation = self.expectation(description: "Generate the error response while receiving the unknown response")

        sut.requestTheUserDetails { userDetailsModel, errorObject in
            XCTAssertNil(userDetailsModel)
            XCTAssertEqual(errorObject, UserDetailsError.reponseModelParsingError)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }

    func testUserDetailsWhenSendEmptyURL() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        let jsonData = "{\"userId\":1,\"id\":1,\"title\":\"delectus aut autem\",\"completed\":false}".data(using: .utf8)
        MockURLProtocol.stubResponseData = jsonData
 let sut = UserDetailsWebService(urlString: "", urlSession: urlSession)
        let expectation = self.expectation(description: "Blank URL passed")

        sut.requestTheUserDetails { userDetailsModel, errorObject in
            XCTAssertEqual(errorObject, UserDetailsError.blankURLError)
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 5)
    }

}
