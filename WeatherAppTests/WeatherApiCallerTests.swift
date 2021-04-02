//
//  WeatherApiCallerTests.swift
//  WeatherAppTests
//
//  Created by Srijan Bhatia on 20/03/21.
//

import XCTest

@testable import WeatherApp

class WeatherApiCallerTests: BaseApiMethods {
    
    var apiCaller: WeatherApiCaller?
    
    func setUpApiCaller(baseURL: String) {
        apiCaller = WeatherApiCaller(baseURL: baseURL)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNameCorrectInWeatherModel() {
        
        self.setUpApiCaller(baseURL: UtilityMethods.getBaseURL())
        let arguments = UtilityMethods.getDelhiArguments()
        let exp = self.getCallbackCalledExpectation()
        let callback: (WeatherModel) -> Void = {weatherModel in
            XCTAssertEqual(weatherModel.name, "Delhi")
            exp.fulfill()
        }
        apiCaller?.getWeatherModel(arguments: arguments, closure: callback)
        self.waitForExpectationsWithTimeout(2)
    }
    
    func testIdCorrectInWeatherModel() {
        
        self.setUpApiCaller(baseURL: UtilityMethods.getBaseURL())
        let arguments = UtilityMethods.getDelhiArguments()
        let exp = self.getCallbackCalledExpectation()
        let callback: (WeatherModel) -> Void = {weatherModel in
            XCTAssertEqual(weatherModel.id, 1273294)
            exp.fulfill()
        }
        apiCaller?.getWeatherModel(arguments: arguments, closure: callback)
        self.waitForExpectationsWithTimeout(2)
    }

}
