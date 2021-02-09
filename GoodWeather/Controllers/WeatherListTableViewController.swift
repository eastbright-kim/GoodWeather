//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by 김동환 on 2021/02/08.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController, MakingWeatherViewModelDelegate, SetUnit{
   
    func setTableview() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    let defaults = UserDefaults.standard
    var weatherListViewModel = WeatherListViewModel()
    static var shared = WeatherListTableViewController()
    var isCelsius = true
    var unitDefault: Bool?
    
    
    
    func appendWeatherVM(cityName: String, vc: UIViewController) {
        
        Webservice().fetchWether(cityName: cityName) { (weatherModel) -> Void in
            let newCityWeatherVM = WeatherViewModel(weatherModel: weatherModel)
            self.weatherListViewModel.weatherListViewModel.append(newCityWeatherVM)
        }
    }
    
    func tableViewReload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
//        isCelsius = defaults.bool(forKey: "celsiusOrfeh")
//        print(isCelsius)
        unitDefault = defaults.bool(forKey: "TrueOrNot")
        print(unitDefault)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MainToAdd" {
            if let navC = segue.destination as? UINavigationController {
                
                guard let addcityVC = navC.viewControllers.first as? AddCityViewController else {
                    fatalError()
                }
                addcityVC.delegate = self
            }
        } else {
            if let navC = segue.destination as? UINavigationController {
                
                guard let settingsVC = navC.viewControllers.first as? SettingsTableViewController else {
                    fatalError()
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
            fatalError()
        }
        
        if let cityName = weatherListViewModel.weatherListViewModel[indexPath.row].cityName,
           let temperature = weatherListViewModel.weatherListViewModel[indexPath.row].temperature,
           let fah = weatherListViewModel.weatherListViewModel[indexPath.row].fahrenheit
        {
            cell.cityNameLabel.text = cityName
            
            if let defaults = self.unitDefault {
                
                if defaults == true {
                    if WeatherListTableViewController.shared.isCelsius == true {
                        let result = defaults ? temperature : fah
                        cell.degreeLabel.text = result
                        print("here1\(defaults)")
                    } else {
                        let result = WeatherListTableViewController.shared.isCelsius ? temperature : fah
                        cell.degreeLabel.text = result
                        print("here1\(defaults)")
                    }
                    

                } else {
                    if WeatherListTableViewController.shared.isCelsius == true {
                        let result = defaults ? temperature : fah
                        cell.degreeLabel.text = result
                        print("here1\(defaults)")
                    } else {
                        let changedValue = WeatherListTableViewController.shared.isCelsius
                        let result = changedValue ? temperature : fah
                        cell.degreeLabel.text = result
                        print("here1\(defaults)")
                    }
                    
                    
                }
                
                
                
//
//
//                print(defaults)
//                let changedValue = WeatherListTableViewController.shared.isCelsius
//                print(changedValue)
//                if defaults == changedValue {
//                    let result = defaults ? temperature : fah
//                    cell.degreeLabel.text = result
//                    print("here1\(defaults)")
//                } else {
//                    let result = changedValue ? temperature : fah
//                    cell.degreeLabel.text = result
//                    print("here2\(defaults)")
//                }
//
//
//                WeatherListTableViewController.shared.isCelsius = defaults
//
//                let b = WeatherListTableViewController.shared.isCelsius
//
//                let result = WeatherListTableViewController.shared.isCelsius ? temperature : fah
//                cell.degreeLabel.text = result
//                print("here1\(defaults)")
//
//
//                if WeatherListTableViewController.shared.isCelsius != b {
//                    let result = b ? temperature : fah
//                    cell.degreeLabel.text = result
//                    print("here1\(defaults)")
//                }
//
            
//
//                if WeatherListTableViewController.shared.isCelsius == defaults {
//                    let result = defaults ? temperature : fah
//                    cell.degreeLabel.text = result
//                    print("here1\(defaults)")
//                } else {
//                    let result = WeatherListTableViewController.shared.isCelsius ? temperature : fah
//                    cell.degreeLabel.text = result
//                    print("here2\(defaults)")
//                }
//
//
                
//                if WeatherListTableViewController.shared.isCelsius != defaults {
//                    let result = WeatherListTableViewController.shared.isCelsius ? temperature : fah
//                    cell.degreeLabel.text = result
//                    print("here1\(defaults)")
//                } else {
//                    let result = defaults ? temperature : fah
//                    cell.degreeLabel.text = result
//                }
//
//                WeatherListTableViewController.shared.isCelsius = defaults
//                let result = WeatherListTableViewController.shared.isCelsius ? temperature : fah
//                cell.degreeLabel.text = result
//                print("here1\(defaults)")
//            }else {
//                let result = WeatherListTableViewController.shared.isCelsius ? temperature : fah
//                cell.degreeLabel.text = result
//                print("here2\(result)")
                //            }
                //
                //            if WeatherListTableViewController.shared.isCelsius != self.unitDefault {
                //
                //            }
                
                
            }
            
            
        }
        return cell
    }
}
