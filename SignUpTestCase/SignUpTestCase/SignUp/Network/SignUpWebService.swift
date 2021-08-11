//
//  SignUpWebServic.swift
//  SignUpTestCase
//
//  Created by Monica Mishipay on 11/08/21.
//

import Foundation

class SignUpWebService: SignupWebServiceProtocol {

    private var urlString: String
    private var urlSession: URLSession

    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }

    func signup(withForm: SignUpRequestModel,
                completion: @escaping(SignUpResponseModel?, SignUpError?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, SignUpError.invalidURLStringError)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(withForm)

        let dataTask =  urlSession.dataTask(with: request) { (data, response, error) in
            if let requestError = error {
                completion(nil, SignUpError.failedRequest(description: "A localised error description of an error"))
                return
            }

           if let data = data,
              let signUpResponseModel = try? JSONDecoder().decode(SignUpResponseModel.self, from: data)
           {
            completion(signUpResponseModel, nil)
           } else {
            completion(nil, SignUpError.responseModelParsingError)
           }
        }

        dataTask.resume()

    }
}
