//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Clément Garcia on 29/03/2022.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectWeatherDefaultCities()
    }
    
    // MARK: - Var
    //Instance of the Weather data provider model
    private let weather = WeatherService()
    private var cityListCurrentWeather = [weatherStruct]()
    private var cityListCurrentWeatherSorted = [weatherStruct]()
    private var defaultCityList = [CityStruct(lat: "40.714272", lon: "-74.005966"), //NewYork
                                   CityStruct(lat: "51.966671", lon: "-8.58333"), //Cork
                                   CityStruct(lat: "48.853401", lon: "2.3486"), //Paris
                                   CityStruct(lat: "44.833328", lon: "-0.56667"), //Bordeaux
                                   CityStruct(lat: "45.4333", lon: "4.4") //Saint-Etienne
    ]
    
    // MARK: - IBOutlets
    @IBOutlet weak var cityListTableView: UITableView!
    @IBOutlet weak var loadingStackView: UIStackView!
    
    // MARK: - IBAction
    @IBAction func tappedReloadButton(_ sender: Any) {
        cityListCurrentWeather = []
        cityListTableView.reloadData()
        collectWeatherDefaultCities()
    }
    
    // MARK: - Functions
    /// Retreive the weather datas using the model instance.
    func loadWeatherDatas(lat: String, lon: String, group: DispatchGroup?){
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
                
                if let group = group {
                    group.leave()
                }
            }
        }
    }
    
    /// Add weather data within a list to be displayed by the TableView, then the table view is reloaded
    /// - Parameter weatherData: weather data to display within the TableView
    func addWeatherFor(weatherData: weatherStruct) {
        cityListCurrentWeather.append(weatherData)
        cityListCurrentWeatherSorted = cityListCurrentWeather.sorted(by: { $0.name < $1.name })
        cityListTableView.reloadData()
    }
}

// MARK: - Extensions - Related to Table View
//To conform at UITableViewDataSource protocol. (this is required to diplay current city list weather within a table view)
extension WeatherViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityListCurrentWeatherSorted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        let index = indexPath.row
        let affectedCity = cityListCurrentWeatherSorted[index]
        cell.configure(for: affectedCity.name, condition: affectedCity.weather[0].description, temp: "\(affectedCity.main["temp"]!)°C (Min: \(affectedCity.main["temp_min"]!)°C Max: \(affectedCity.main["temp_max"]!)°C)")
        return cell
    }
}

//To conform at UITableViewDDelegate protocol. (this is required to edit current city list weather within a table view)
extension WeatherViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cityListCurrentWeatherSorted.remove(at: indexPath.row)
            cityListTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - Extensions - Related to Dispatch Group
extension WeatherViewController{
    
    func collectWeatherDefaultCities() {
        toggleActivityIndicator(hide: cityListTableView, display: loadingStackView)
        let group = DispatchGroup()
        for city in defaultCityList {
            group.enter()
            self.loadWeatherDatas(lat: city.lat, lon: city.lon, group: group)
        }
        group.notify(queue: DispatchQueue.main) {
            self.cityListTableView.reloadData()
            self.toggleActivityIndicator(hide: self.loadingStackView, display: self.cityListTableView)
        }
    
    }
    
}
