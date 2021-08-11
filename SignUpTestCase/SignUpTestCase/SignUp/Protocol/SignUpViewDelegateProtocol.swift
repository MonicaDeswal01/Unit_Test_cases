//
//  SignUpViewDelegateProtocol.swift
//  SignUpTestCase
//
//  Created by Monica Mishipay on 11/08/21.
//

import Foundation

protocol SignUpViewDelegateProtocol: AnyObject {
    func successfullySignUp()
    func errorHandler(error: SignUpError)
}
