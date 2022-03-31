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
        loadWeatherDatas()
        toggleLoadingScreen(display: false)
    }
    
    // MARK: - Var
    //Instance of the Weather data provider model
    private let weather = WeatherService()
    
    // MARK: - IBOutlets
    @IBOutlet weak var stackViewLoading: UIStackView!
    @IBOutlet weak var stackViewCity: UIStackView!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    // MARK: - IBActions
    @IBAction func tappedRefrehButton(_ sender: Any) {
        toggleLoadingScreen(display: true)
        loadWeatherDatas()
        toggleLoadingScreen(display: false)
    }
    
    // MARK: - Functions
    /// Retreive the weather datas using the model instance.
    func loadWeatherDatas(){
        
        weather.retreiveWeatherFor() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.displayWeatherData(weatherData: data)
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
    
    /// Display the weather's data retrived into the label UILabel
    /// - Parameter weatherData: Weather do diplay.
    func displayWeatherData(weatherData: weatherStruct) {
        let text = "\(weatherData.name) \nCondition: \(weatherData.weather[0].description)\nCurrent temp: \(weatherData.main["temp"]!)\nMin: \(weatherData.main["temp_min"]!)\nMax: \(weatherData.main["temp_max"]!)"
        cityLabel.text = text
    }
    
    /// Used to display the loading screen.
    /// - Parameter display: True to display the loading view. False to hide
    func toggleLoadingScreen(display: Bool){
        stackViewLoading.isHidden = !display
        stackViewCity.isHidden = display
    }
}
