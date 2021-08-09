//
//  UserDetailsWebService.swift
//  IntegrationTest
//
//  Created by Monica Mishipay on 09/08/21.
//

import Foundation

struct UserDetailsWebService {
    private var urlString: String
    private var urlSession: URLSession

    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }

    func requestTheUserDetails(completionHandler: @escaping(UserDetailsModel?, UserDetailsError?) -> Void) {
        guard let url = URL(string: urlString) else {
            //TODO: Handle invalid url
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in

            if let data = data, let userDetailModel = try? JSONDecoder().decode(UserDetailsModel.self, from: data) {
             completionHandler(userDetailModel, nil)
            } else {
                //TODO error handling

            }

        }

        dataTask.resume()


    }
}
