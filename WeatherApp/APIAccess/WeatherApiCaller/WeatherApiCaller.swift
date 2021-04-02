//
//  WeatherApiCaller.swift
//  WeatherApp
//
//  Created by Srijan Bhatia on 20/03/21.
//

import Foundation

class WeatherApiCaller: BaseApiCaller {
    
    func getWeatherModel(arguments: Array<ParameterValueModel>, closure: @escaping (WeatherModel) -> Void) {
        let dataClosure: (Data) -> Void = { data in
            if let weatherModel = self.createWeatherModelFromData(data) {
                closure(weatherModel)
            }
        }
        self.getJSON(arguments: arguments, closure: dataClosure)
    }
    
    private func createWeatherModelFromData(_ data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let weatherModel = WeatherModel(id: id, name: name, temperature: temp)
            return weatherModel
        } catch {
            print("Error while decoding weather data \(error)")
            return nil
        }
    }
}
