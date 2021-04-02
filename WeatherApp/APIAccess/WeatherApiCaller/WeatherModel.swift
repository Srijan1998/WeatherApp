//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Srijan Bhatia on 20/03/21.
//

import Foundation

struct WeatherModel: Decodable {
    let id: Int
    let name: String
    let temperature: Double
    
    var temp: String {
        return String(format: "%.1f", temperature)
    }
}

struct WeatherData: Decodable {
    let id: Int
    let name: String
    let main: Main
}

struct Main: Decodable {
    let temp: Double
}
