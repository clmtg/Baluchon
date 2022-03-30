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
