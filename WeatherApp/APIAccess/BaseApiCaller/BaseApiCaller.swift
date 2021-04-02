//
//  BaseApiCaller.swift
//  WeatherApp
//
//  Created by Srijan Bhatia on 23/02/21.
//

import Foundation

class BaseApiCaller {
    let baseURL: String
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func getFinalURL(arguments: Array<ParameterValueModel>) -> String {
        var finalURL = self.baseURL
        finalURL += arguments.count > 0 ? "?" : ""
        finalURL += getArgumentString(arguments: arguments)
        return finalURL
    }
    
    private func getArgumentString(arguments: Array<ParameterValueModel>) -> String {
        var argumentString = ""
        for i in 0..<arguments.count {
            argumentString += i != 0 ? "&" : ""
            argumentString += "\(arguments[i].parameter)=\(arguments[i].value)"
        }
        return argumentString
    }
    
    func getJSON(arguments: Array<ParameterValueModel>, closure: @escaping (String) -> Void) {
        if (baseURL == "") {
            closure("")
            return
        }
        
        if let url = URL(string: getFinalURL(arguments: arguments)) {
            let session = URLSession(configuration: .default)
            self.handleTask(url: url, session: session, closure: closure)
        }
    }
    
    func getJSON(arguments: Array<ParameterValueModel>, closure: @escaping (Data) -> Void) {
        if (baseURL == "") {
            closure(Data())
            return
        }
        
        if let url = URL(string: getFinalURL(arguments: arguments)) {
            let session = URLSession(configuration: .default)
            self.handleTask(url: url, session: session, closure: closure)
        }
    }
    
    private func handleTask(url: URL, session: URLSession, closure: @escaping (String) -> Void) {
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if error == nil {
                if let safeData = data {
                    if let dataString = String(data: safeData, encoding: .utf8) {
                        closure(dataString)
                    }
                }
            }
        })
        task.resume()
    }
    
    private func handleTask(url: URL, session: URLSession, closure: @escaping (Data) -> Void) {
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if error == nil {
                if let safeData = data {
                    closure(safeData)
                }
            }
        })
        task.resume()
    }
}
