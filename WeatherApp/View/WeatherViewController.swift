//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Srijan Bhatia on 23/02/21.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    var weatherPresenter: WeatherPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityTextField.delegate = self
        weatherPresenter = WeatherPresenter(delegate: self)
    }

}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.cityTextField.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let placeText = textField.text {
            self.weatherPresenter?.getTemperatureForPlace(placeText)
        }
    }
}

extension WeatherViewController: WeatherPresenterDelegate {
    func updateTemperatureLabel(temperature temperatureString: String) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = temperatureString
        }
    }
}

