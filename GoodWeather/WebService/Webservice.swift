//
//  Webservice.swift
//  GoodWeather
//
//  Created by 김동환 on 2021/02/09.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case dataError
    case decodingError
}

struct Webservice {
    
    func fetchWether(cityName: String, completion: @escaping ((Result<WeatherModel,NetworkError>) -> Void)){
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=e61267c07543e45b46ba83f54ac8fb03") else {
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.dataError))
                return
            }
            guard let decoded = try? JSONDecoder().decode(WeatherModel.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            DispatchQueue.main.async {
                completion(.success(decoded))
            }
        }.resume()
    }
}
