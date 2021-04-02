//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Srijan Bhatia on 29/03/21.
//

import Foundation

struct WeatherPresenter {
    var weatherPresenterDelegate: WeatherPresenterDelegate?
    private var apiCaller: WeatherApiCaller
    init(delegate: WeatherPresenterDelegate?) {
        self.apiCaller = WeatherApiCaller(baseURL: UtilityMethods.getBaseURL())
        self.weatherPresenterDelegate = delegate
    }
    
    func createParameterValueModel(_ parameter: String, _ value: Any) -> ParameterValueModel {
        return ParameterValueModel(parameter: parameter, value: value)
    }
    
    func getTemperatureForPlace(_ place: String) {
        let arguments = UtilityMethods.getDelhiArguments()
        let callback: (WeatherModel) -> Void = {weatherModel in
            self.weatherPresenterDelegate?.updateTemperatureLabel(temperature: weatherModel.temp)
        }
        self.apiCaller.getWeatherModel(arguments: arguments, closure: callback)
    }
}


