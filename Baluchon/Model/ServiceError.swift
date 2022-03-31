//
//  CurrencyServiceError.swift
//  Baluchon
//
//  Created by Clément Garcia on 28/03/2022.
//

import Foundation

enum ServiceError: Error {
    case corruptData
    case unexpectedResponse
    case jsonInvalid
}

extension ServiceError: CustomStringConvertible {
    var description: String {
        switch self {
        case .corruptData: return "Data appears to be corrupted."
        case .unexpectedResponse: return "The server provided an unexpected response."
        case .jsonInvalid: return "JSON received doesn't conform to pattern."
        }
    }
}
