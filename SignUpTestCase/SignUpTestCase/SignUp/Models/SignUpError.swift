//
//  SignUpError.swift
//  SignUpTestCase
//
//  Created by Monica Mishipay on 11/08/21.
//

import Foundation

enum SignUpError: LocalizedError, Equatable {
    case responseModelParsingError
    case invalidURLStringError
    case failedRequest(description: String)

    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidURLStringError, .responseModelParsingError:
            return ""
        }
    }
}
