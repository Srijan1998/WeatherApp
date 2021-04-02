//
//  WeatherPresenterDelegateHelper.swift
//  WeatherAppTests
//
//  Created by Srijan Bhatia on 29/03/21.
//

import XCTest

class WeatherPresenterSpyDelegate: WeatherPresenterDelegate {
    var delegateExpectation: XCTestExpectation?
    var temperatureUpdated: Bool? = nil
    
    func updateTemperatureLabel(temperature temperatureString: String) {
        delegateExpectation?.fulfill()
        temperatureUpdated = true
    }
}
