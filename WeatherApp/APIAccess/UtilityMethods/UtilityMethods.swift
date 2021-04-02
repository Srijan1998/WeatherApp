//
//  UtilityMethods.swift
//  WeatherApp
//
//  Created by Srijan Bhatia on 02/04/21.
//

import Foundation

struct UtilityMethods {
    private static func createParameterValueModel(_ parameter: String, _ value: Any) -> ParameterValueModel {
        return ParameterValueModel(parameter: parameter, value: value)
    }

    static func getDelhiArguments() -> Array<ParameterValueModel> {
        var arguments = [ParameterValueModel]()
        arguments.append(self.createParameterValueModel("appid", Constants.weatherApiKey))
        arguments.append(self.createParameterValueModel("units", "metric"))
        arguments.append(self.createParameterValueModel("q", "delhi"))
        return arguments
    }
    static func getBaseURL() -> String {
        return "https://api.openweathermap.org/data/2.5/weather"
    }
}
