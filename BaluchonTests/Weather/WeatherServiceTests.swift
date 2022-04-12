//
//  WeatherServiceTests.swift
//  BaluchonTests
//
//  Created by Clément Garcia on 12/04/2022.
//

import XCTest
@testable import Baluchon

class WeatherServiceTests: XCTestCase {
    
    // MARK: - Vars
    
    //Fake session confirguration set in order to preform unit tests
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration=URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses=[URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // MARK: - Related to network
    
    func testGivenServiceisAvailable_WhenRequestWeatherData_ThenNoErrorThrown() {
        URLProtocolFake.fakeURLs = [FakeResponseData.weatherUrl: (FakeResponseData.weatherCorrectData,
                                                                   FakeResponseData.validResponse,
                                                                   nil)]
        
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut = WeatherService(session: fakeSession)
        let expectation = XCTestExpectation(description: "Waiting...")
        
        sut.retreiveWeatherFor(lat: "45.4333", lon: "4.4") { result in
            guard case .success(let data) = result else {
                XCTFail(#function)
                return
            }
            XCTAssertEqual(data.weather[0].description, "ciel dégagé")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenServiceisAvailable_WhenWeatherDataAreIncorrect_ThenErrorThrown() {
        URLProtocolFake.fakeURLs = [FakeResponseData.weatherUrl: (FakeResponseData.incorrectData,
                                                                   FakeResponseData.validResponse,
                                                                   nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut = WeatherService(session: fakeSession)
        let expectation = XCTestExpectation(description: "Waiting...")
        
        sut.retreiveWeatherFor(lat: "45.4333", lon: "4.4") { result in
            guard case .failure(let error) = result else {
                XCTFail(#function)
                return
            }
            XCTAssertEqual(error, ServiceError.jsonInvalid)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenServiceisUnavailable_WhenWeatherDataAreRequested_ThenErrorThrown() {
        URLProtocolFake.fakeURLs = [FakeResponseData.weatherUrl: (nil,
                                                                  FakeResponseData.invalidResponse,
                                                                  ServiceError.unexpectedResponse)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut = WeatherService(session: fakeSession)
        let expectation = XCTestExpectation(description: "Waiting...")
        
        sut.retreiveWeatherFor(lat: "45.4333", lon: "4.4") { result in
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
