//
//  TranslationStruct.swift
//  Baluchon
//
//  Created by Clément Garcia on 31/03/2022.
//

import Foundation

struct TranslationStruct: Decodable {
    let translations: [Sentence]
}

struct Sentence: Decodable {
    let detected_source_language: String?
    let text: String
}
