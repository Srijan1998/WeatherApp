//
//  WeatherPresenterDelegate.swift
//  WeatherApp
//
//  Created by Srijan Bhatia on 29/03/21.
//

import Foundation

protocol WeatherPresenterDelegate {
    func updateTemperatureLabel(temperature temperatureString: String)
}
