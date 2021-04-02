//
//  WeatherPresenterTests.swift
//  WeatherAppTests
//
//  Created by Srijan Bhatia on 29/03/21.
//

import XCTest

@testable import WeatherApp

class WeatherPresenterTests: XCTestCase {
    
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
    
    private func waitForExpectationsWithTimeout(_ timeout: TimeInterval) {
        waitForExpectations(timeout: timeout) { error in
             if let error = error {
               XCTFail("waitForExpectationsWithTimeout errored: \(error)")
             }
           }
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

}
