//
//  WeatherPresenterTests.swift
//  WeatherAppTests
//
//  Created by Srijan Bhatia on 29/03/21.
//

import XCTest

@testable import WeatherApp

class WeatherPresenterTests: BaseApiMethods {
    
    var weatherPresenter: WeatherPresenter?
    var weatherPresenterSpyDelegate: WeatherPresenterSpyDelegate?

    override func setUpWithError() throws {
        self.weatherPresenter = WeatherPresenter(delegate: nil)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func getDelegateExpectation() -> XCTestExpectation {
        return expectation(description: "Delegate Called")
    }
    
    private func setUpWeatherPresenterSpyDelegate() {
        self.weatherPresenterSpyDelegate = WeatherPresenterSpyDelegate()
        self.weatherPresenterSpyDelegate?.delegateExpectation = self.getDelegateExpectation()
        self.weatherPresenter?.weatherPresenterDelegate = weatherPresenterSpyDelegate
    }
    
    func testDelegateCalled() {
        self.setUpWeatherPresenterSpyDelegate()
        self.weatherPresenter?.getTemperatureForPlace("Delhi")
        self.waitForExpectationsWithTimeout(2)
        guard let result = self.weatherPresenterSpyDelegate?.temperatureUpdated else {
            XCTFail("Delegate not called")
            return
        }
        XCTAssertTrue(result)
    }
    
    func testRightTemperature() {
        self.setUpWeatherPresenterSpyDelegate()
        self.weatherPresenter?.getTemperatureForPlace("Delhi")
        self.waitForExpectationsWithTimeout(2)
        var temp: String = ""
        let exp = self.getCallbackCalledExpectation()
        self.getTemperature { (weatherModel) in
            temp = weatherModel.temp
            exp.fulfill()
        }
        self.waitForExpectationsWithTimeout(2)
        guard let temperature = self.weatherPresenterSpyDelegate?.temperature else {
            XCTFail("Delegate not called")
            return
        }
        XCTAssertEqual(temp, temperature)
    }
    
    func getTemperature(closure: @escaping (WeatherModel) -> Void) {
        
        let apiCaller = WeatherApiCaller(baseURL: UtilityMethods.getBaseURL())
        let arguments = UtilityMethods.getDelhiArguments()
        let callback: (WeatherModel) -> Void = {weatherModel in
            closure(weatherModel)
        }
        apiCaller.getWeatherModel(arguments: arguments, closure: callback)
    }


}
