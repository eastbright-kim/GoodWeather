//
//  SettingsTableViewController.swift
//  GoodWeather
//
//  Created by 김동환 on 2021/02/09.
//

import UIKit

protocol SetUnitDelegate {
    func reloadTableviewFromSettings(vc: UIViewController)
}

class SettingsTableViewController: UITableViewController {
    
    let settings = ["Celsius", "Fahrenheit"]
    var isCelsius = true
    var delegate: SetUnitDelegate?
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        cell.textLabel?.text = settings[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            isCelsius = true
            WeatherListTableViewController.shared.isCelsius = isCelsius
        } else {
            isCelsius = false
            WeatherListTableViewController.shared.isCelsius = isCelsius
        }
    }
    
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        defaults.set(WeatherListTableViewController.shared.isCelsius, forKey: "TrueOrNot")
        delegate?.reloadTableviewFromSettings(vc: self)
        dismiss(animated: true, completion: nil)
    }
    
}
