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
    
    //Instance of the location data provider model
    private let coreLocationManager = CoreLocationManager()
    //Has the app succeeded to retreive the user location
    private let locationRetrieved: Bool? = nil
    
    
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
        
        weather.retreiveWeatherFor(lon: -74.0060152, lat: 40.7127281) { success, weatherDatas in
            //In the event where the app can't retrieve the weather datas, an alert is displayed an offer to open app settings
            if let success = success {
                
                var errorMessage: String?
                
                switch success {
                case ServiceError.corruptData:
                    errorMessage = "OpenWeather datas appear to be corrupted."
                    
                case ServiceError.unexpectedResponse:
                    errorMessage = "OpenWeather's server provided an unexpected response."
                    
                case ServiceError.jsonInvalid:
                    errorMessage = "OpenWeather's response doesn't respect JSON pattern."
                    
                default:
                    print("An unkown error occured.")
                }
                
                let openSettingsAction = UIAlertAction(title: "Open Wi-Fi settings", style: .default) { actionTonOpen in
                    if let url = URL.init(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
                let additionalAlertAction = [openSettingsAction]
                self.displayAnAlert(title: "Network error", message: "Fail to retreive rate. \(errorMessage!)\nPlease check your network settings", actions: additionalAlertAction)
                return
            }
            
            self.displayWeatherData(weatherData: weatherDatas!)
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


// MARK: - Locations Services related


extension WeatherViewController {
    
    
    func determineLocation() {
        
        guard let location = coreLocationManager.getCurrentLocation() else {
            let locationRetrieved = false
            return
        }
        
        let latitude = location.latitude
        let longitude = location.longitude
        let coordinates = "\(latitude), \(longitude)"
        let locationRetrieved = true
        
        print(coordinates)
    }
    
    
}
