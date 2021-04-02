//
//  BaseApiCallerTests.swift
//  WeatherAppTests
//
//  Created by Srijan Bhatia on 23/02/21.
//

import XCTest

@testable import WeatherApp

class BaseApiCallerTests: BaseApiMethods {
    
    var apiCaller: BaseApiCaller?

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func setUpApiCaller(baseURL: String) {
        apiCaller = BaseApiCaller(baseURL: baseURL)
    }
    
    func testEmptyApiCall() {
        self.setUpApiCaller(baseURL: "")
        let exp = self.getCallbackCalledExpectation()
        let callback: (String) -> Void = {responseString in
            XCTAssertTrue(responseString == "", "Wrong response")
            exp.fulfill()
        }
        apiCaller?.getJSON(arguments: [ParameterValueModel](), closure: callback)
        self.waitForExpectationsWithTimeout(2)
    }
    
    func testResponseOnlyBaseURL() {
        self.setUpApiCaller(baseURL: UtilityMethods.getBaseURL())
        let exp = self.getCallbackCalledExpectation()
        let callback: (String) -> Void = {responseString in
            XCTAssertTrue(responseString.contains("401") == true, "Wrong response")
            exp.fulfill()
        }
        apiCaller?.getJSON(arguments: [ParameterValueModel](), closure: callback)
        self.waitForExpectationsWithTimeout(2)
    }
    
    func testFinalURLGivenOnlyBaseURL() {
        self.setUpApiCaller(baseURL: UtilityMethods.getBaseURL())
        XCTAssertEqual(apiCaller?.getFinalURL(arguments: [ParameterValueModel]()), "https://api.openweathermap.org/data/2.5/weather")
    }
    
    func testFinalURLWithArguments() {
        self.setUpApiCaller(baseURL: UtilityMethods.getBaseURL())
        let arguments = UtilityMethods.getDelhiArguments()
        XCTAssertEqual(apiCaller?.getFinalURL(arguments: arguments), "https://api.openweathermap.org/data/2.5/weather?appid=7ecbe89f39ce1022e895fe14b95c7eaa&units=metric&q=delhi")
    }
    
    func testResponseWithApiKey() {
        self.setUpApiCaller(baseURL: UtilityMethods.getBaseURL())
        let arguments = UtilityMethods.getDelhiArguments()
        let exp = self.getCallbackCalledExpectation()
        let callback: (String) -> Void = {responseString in
            XCTAssertTrue(responseString != "", "Wrong response")
            XCTAssertTrue(responseString.contains("weather") == true, "Wrong response")
            exp.fulfill()
        }
        apiCaller?.getJSON(arguments: arguments, closure: callback)
        self.waitForExpectationsWithTimeout(2)
    }
}
