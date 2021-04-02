//
//  BaseApiMethods.swift
//  WeatherAppTests
//
//  Created by Srijan Bhatia on 29/03/21.
//

import XCTest

class BaseApiMethods: XCTestCase {

    func waitForExpectationsWithTimeout(_ timeout: TimeInterval) {
        waitForExpectations(timeout: timeout) { error in
             if let error = error {
               XCTFail("waitForExpectationsWithTimeout errored: \(error)")
             }
           }
    }
    
    func getCallbackCalledExpectation() -> XCTestExpectation {
        return expectation(description: "Callback called")
    }
}
