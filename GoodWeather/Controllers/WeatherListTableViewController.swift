//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by 김동환 on 2021/02/08.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController{
    
    let defaults = UserDefaults.standard
    var weatherListViewModel = WeatherListViewModel()
    static var shared = WeatherListTableViewController()
    var isCelsius: Bool? = nil
    var unitDefault: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        unitDefault = defaults.bool(forKey: "TrueOrNot")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MainToAdd" {
            if let navC = segue.destination as? UINavigationController {
                guard let addcityVC = navC.viewControllers.first as? AddCityViewController else {
                    fatalError("Add segue vc error occur")
                }
                addcityVC.delegate = self
            }
        } else {
            if let navC = segue.destination as? UINavigationController {
                
                guard let settingsVC = navC.viewControllers.first as? SettingsTableViewController else {
                    fatalError("Setting segue vc error occur")
                }
                settingsVC.delegate = self
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.weatherListViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherTableViewCell else {
            fatalError("cell error occur")
        }
        
        let cityName = weatherListViewModel.weatherListViewModel[indexPath.row].cityName
        let celsius = weatherListViewModel.weatherListViewModel[indexPath.row].celsius
        let fah = weatherListViewModel.weatherListViewModel[indexPath.row].fahrenheit
        
        cell.cityNameLabel.text = cityName
        
        if let checkIfUnitSelected = WeatherListTableViewController.shared.isCelsius {
            let result = checkIfUnitSelected ? celsius : fah
            cell.degreeLabel.text = result
        } else {
            let defaults = self.unitDefault
            let result = defaults ? celsius : fah
            cell.degreeLabel.text = result
        }
        return cell
    }
}

// MARK: - Protocol Extension

extension WeatherListTableViewController: MakingWeatherViewModelDelegate, SetUnitDelegate {
    
    func appendWeatherVM(cityName: String, vc: UIViewController) {
        
        Webservice().fetchWether(cityName: cityName) { (weatherModel) -> Void in
            switch weatherModel {
            case .success(let weatherModel):
                let newCityWeatherVM = WeatherViewModel(weatherModel: weatherModel)
                self.weatherListViewModel.weatherListViewModel.append(newCityWeatherVM)
            case .failure(let error):
                print(error)
                fatalError()
            }
        }
    }
    
    func reloadTableviewFromSettings(vc: UIViewController) {
            self.tableView.reloadData()
    }
    
    func tableViewReloadFromAddcity(vc: UIViewController) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


