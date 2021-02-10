//
//  WeatherViewModel.swift
//  GoodWeather
//
//  Created by 김동환 on 2021/02/09.
//

import Foundation

struct WeatherListViewModel {
    
    var weatherListViewModel: [WeatherViewModel]
}

extension WeatherListViewModel {
    
    init() {
        weatherListViewModel = [WeatherViewModel]()
    }
}

struct WeatherViewModel {
    
    let weatherModel: WeatherModel
}

extension WeatherViewModel {
    
    var cityName: String? {
        return weatherModel.name
    }
    
    var temperature: String? {
        get{
            let kelvin = weatherModel.main.temp
            let celsius = kelvin - 273
            return String(format: "%.2f", celsius)
        }
        
    }
    var fahrenheit: String? {
        get{
            let kelvin = weatherModel.main.temp
            let fah = (kelvin - 273) * 1.8 + 32
            return String(format: "%.2f", fah)
        }
    }
}
