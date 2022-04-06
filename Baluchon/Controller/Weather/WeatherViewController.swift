//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Clément Garcia on 29/03/2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeatherDatas(lat: "40.7127281", lon: "-74.0060152")
    }
    
    // MARK: - Var
    //Instance of the Weather data provider model
    private let weather = WeatherService()
    private var cityListCurrentWeather = [weatherStruct]()
    
    // MARK: - IBOutlets
    @IBOutlet weak var cityListTableView: UITableView!
    
    // MARK: - IBActions
    @IBAction func londonButtonTapped(_ sender: Any) {
        loadWeatherDatas(lat: "46.3295", lon: "12.1122")
    }
    
    
    // MARK: - Functions
    /// Retreive the weather datas using the model instance.
    func loadWeatherDatas(lat: String, lon: String){
        
        weather.retreiveWeatherFor(lat: lat, lon: lon) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self!.addWeatherFor(weatherData: data)
                    
                case .failure(let error):
                    let openSettingsAction = UIAlertAction(title: "Open Wi-Fi settings", style: .default) { actionTonOpen in
                        if let url = URL.init(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                    let additionalAlertAction = [openSettingsAction]
                    self?.displayAnAlert(title: "Network error", message: "Fail to retreive weather data. \(error.description)\nPlease check your network settings", actions: additionalAlertAction)
                }
            }
        }
    }
    
    
    
    /// Add weather data within a list to be displayed by the TableView, then the table view is reloaded
    /// - Parameter weatherData: weather data to display within the TableView
    func addWeatherFor(weatherData: weatherStruct) {
        cityListCurrentWeather.append(weatherData)
        cityListTableView.reloadData()
    }
    
}

// MARK: - Extensions

//To conform at UITableViewDataSource protocol. (this is required to diplay current city list weather within a table view)
extension WeatherViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityListCurrentWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        
        let index = indexPath.row
        let affectedCity = cityListCurrentWeather[index]
        cell.configure(for: affectedCity.name, condition: affectedCity.weather[0].description, temp: "Temp: \(affectedCity.main["temp"]!) Min: \(affectedCity.main["temp_min"]!) Max: \(affectedCity.main["temp_max"]!)")
        return cell
        
    }
}


//To conform at UITableViewDDelegate protocol. (this is required to edit current city list weather within a table view)
extension WeatherViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cityListCurrentWeather.remove(at: indexPath.row)
            cityListTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
}


