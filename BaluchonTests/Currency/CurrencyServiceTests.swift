//
//  CurrencyServiceTests.swift
//  BaluchonTests
//
//  Created by Clément Garcia on 12/04/2022.
//
//Given When Then

import XCTest
@testable import Baluchon

class CurrencyServiceTests: XCTestCase {
    
    // MARK: - Vars
    
    //Fake session confirguration set in order to preform unit tests
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration=URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses=[URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // MARK: - Non-Related to network
    
    func testGivenAmountAndRateProvided_WhenConvertAmount_ThenResultIsCorrect() {
        let sut = CurrencyService()
        let result = sut.convertAmount(from: 2.34, with: 1.086189)
        XCTAssertEqual(result, 2.54168226)
    }
    
    // MARK: - Related to network
    
    
    func testGivenServiceisAvailable_WhenLatestRateAreCorrect_ThenNoErrorThrown() {
        URLProtocolFake.fakeURLs = [FakeResponseData.currencyUrl: (FakeResponseData.currencyCorrectData,
                                                                   FakeResponseData.validResponse,
                                                                   nil)]
        
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut = CurrencyService(session: fakeSession)
        let expectation = XCTestExpectation(description: "Waiting...")
        
        sut.retreiveRates { result in
            guard case .success(let data) = result else {
                XCTFail(#function)
                return
            }
            XCTAssertEqual(data.rates["USD"], 1.086189)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenServiceisAvailable_WhenLatestRateAreNotCorrectJson_ThenErrorIsThrown() {
        URLProtocolFake.fakeURLs = [FakeResponseData.currencyUrl: (FakeResponseData.incorrectData,
                                                                   FakeResponseData.validResponse,
                                                                   nil)]
        
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut = CurrencyService(session: fakeSession)
        let expectation = XCTestExpectation(description: "Waiting...")
        
        sut.retreiveRates { result in
            guard case .failure(let error) = result else {
                XCTFail(#function)
                return
            }
            XCTAssertEqual(error, ServiceError.jsonInvalid)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenServiceIsUnavailable_WhenAttemptToGetRates_ThenErrorIsThrown() {
        URLProtocolFake.fakeURLs = [FakeResponseData.currencyUrl: (nil,
                                                                   FakeResponseData.invalidResponse,
                                                                   ServiceError.unexpectedResponse)]
        
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut = CurrencyService(session: fakeSession)
        let expectation = XCTestExpectation(description: "Waiting...")
        
        sut.retreiveRates { result in
            guard case .failure(let error) = result else {
                XCTFail(#function)
                return
            }
            XCTAssertEqual(error, ServiceError.unexpectedResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
