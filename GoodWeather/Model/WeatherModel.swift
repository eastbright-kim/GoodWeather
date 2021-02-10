//
//  WeatherModel.swift
//  GoodWeather
//
//  Created by 김동환 on 2021/02/09.
//

import Foundation

struct WeatherModel: Decodable {
    
    let name: String
    let main: Main
}

struct Main: Decodable {
    
    let temp: Double
}
