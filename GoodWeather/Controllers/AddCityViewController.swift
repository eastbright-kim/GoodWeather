//
//  AddCityViewController.swift
//  GoodWeather
//
//  Created by 김동환 on 2021/02/08.
//

import Foundation
import UIKit

protocol MakingWeatherViewModelDelegate {
    func appendWeatherVM(cityName: String, vc: UIViewController)
    func tableViewReloadFromAddcity(vc: UIViewController)
}

class AddCityViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    var cityName: String?
    var delegate: MakingWeatherViewModelDelegate?
    
    
    
    @IBAction func saveCityButtonPressed(){
        if let cityName = cityNameTextField.text {
            self.cityName = cityName
            delegate?.appendWeatherVM(cityName: cityName, vc: self)
        }
    }
    @IBAction func close(){
        delegate?.tableViewReloadFromAddcity(vc: self)
        self.dismiss(animated: true, completion: nil)
    }
}
