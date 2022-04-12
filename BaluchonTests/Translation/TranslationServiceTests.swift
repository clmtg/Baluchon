//
//  TranslationServiceTests.swift
//  BaluchonTests
//
//  Created by Clément Garcia on 12/04/2022.
//

import XCTest
@testable import Baluchon

class TranslationServiceTests: XCTestCase {
    
    // MARK: - Vars
    
    //Fake session confirguration set in order to preform unit tests
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration=URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses=[URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // MARK: - Unrelated to network
    
    func testGivenInputTextIsEmpty_WhenRequestTranslation_ThenErrorThrown() {
        let sut = TranslationService()
        let expectation = XCTestExpectation(description: "Waiting...")
        
        sut.translateText(text: "", from: "FR", to: "EN-GB") { result in
            guard case .failure(let error) = result else {
                XCTFail(#function)
                return
            }
            XCTAssertEqual(error, ServiceError.missingText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenSourceLangIsMissing_WhenRequestTranslation_ThenErrorThrown() {
        let sut = TranslationService()
        let expectation = XCTestExpectation(description: "Waiting...")
        
        sut.translateText(text: "La voiture est rouge.", from: "", to: "EN-GB") { result in
            guard case .failure(let error) = result else {
                XCTFail(#function)
                return
            }
            XCTAssertEqual(error, ServiceError.missingSourceLangue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenTargetLangIsMissing_WhenRequestTranslation_ThenErrorThrown() {
        let sut = TranslationService()
        let expectation = XCTestExpectation(description: "Waiting...")
        
        sut.translateText(text: "La voiture est rouge.", from: "FR", to: "") { result in
            guard case .failure(let error) = result else {
                XCTFail(#function)
                return
            }
            XCTAssertEqual(error, ServiceError.missingTargetLangue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Related to network
    
    func testGivenServiceIsAvailable_WhenRequestTranslation_ThenNoErrorThrown() {
        URLProtocolFake.fakeURLs = [FakeResponseData.translationUrl: (FakeResponseData.translationCorrectData, FakeResponseData.validResponse, nil)]
        
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut = TranslationService(session: fakeSession)
        let expectation = XCTestExpectation(description: "Waiting...")
      
    }
    
   
}

