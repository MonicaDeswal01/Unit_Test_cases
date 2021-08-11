//
//  SignupWebServiceProtocol.swift
//  SignUpTestCase
//
//  Created by Monica Mishipay on 11/08/21.
//

import Foundation

protocol SignupWebServiceProtocol {
    func signup(withForm: SignUpRequestModel,
                completion: @escaping(SignUpResponseModel?, SignUpError?) -> Void)
}
