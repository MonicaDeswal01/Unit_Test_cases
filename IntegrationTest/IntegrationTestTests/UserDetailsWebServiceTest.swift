//
//  UserDetailsWebServiceTest.swift
//  IntegrationTestTests
//
//  Created by Monica Mishipay on 09/08/21.
//

import XCTest
@testable import IntegrationTest

class UserDetailsWebServiceTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApiResponseSuccessful() {

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
//        let urlSession = URLSession(configuration: configuration)
//        let jsonData = "{\"userId\":1,\"id\":1,\"title\":\"delectus aut autem\",\"completed\":false}".data(using: .utf8)
//        MockURLProtocol.stubResponseData = jsonData
        let sut = UserDetailsWebService(urlString: "https://jsonplaceholder.typicode.com/todos/1", urlSession: URLSession.shared)
        let expectation = self.expectation(description: "User details request")

        sut.requestTheUserDetails { userDetailsModel, errorObject in
            XCTAssertNotNil(userDetailsModel?.id)
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 5)
    }

}
