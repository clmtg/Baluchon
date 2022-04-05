//
//  CurrencyServiceError.swift
//  Baluchon
//
//  Created by Clément Garcia on 28/03/2022.
//

import Foundation

//Enumeration which list the error case for the services used here.
enum ServiceError: Error {
    case corruptData
    case unexpectedResponse
    case jsonInvalid
    case missingText
    case missingSourceLangue
    case missingTargetLangue
}

extension ServiceError: CustomStringConvertible {
    var description: String {
        switch self {
        case .corruptData: return "Data appears to be corrupted."
        case .unexpectedResponse: return "The server provided an unexpected response."
        case .jsonInvalid: return "JSON received doesn't conform to pattern."
        case .missingText: return "Text to translate is empty."
        case .missingSourceLangue: return "We've been unable to detect the langue of the text input"
        case .missingTargetLangue: return "No target language has been selected"
        }
    }
}
